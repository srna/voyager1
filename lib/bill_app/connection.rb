require 'net/http'
require 'bill_app/invoice'
require 'bill_app/contact'
require 'bill_app/line'

module BillApp
  class Connection
    attr_reader :agenda, :email, :password
    def initialize(options)
      if options.is_a?(Profile)
        @agenda, @email, @password = options.agenda,
            options.email, options.password
      else
        @agenda ||= options[:agenda]
        @email ||= options[:email]
        @password ||= options[:password]
      end
    end

    def valid?
      uri = URI(@agenda)
      request = Net::HTTP::Get.new(uri)
      request.basic_auth(@email, @password)
      response = Net::HTTP.start(uri.hostname, uri.port,
                                 use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end
      response.code == "200"
    rescue
      false
    end

    def invoices
      invoices = {}
      get('/invoices.json').parsed_response.each do |i|
        invoices[i['invoice']['id']] =
            BillApp::Invoice.new(i['invoice']['id'],
                                 i['invoice']['number'],
                                 contact(i['invoice']['client_id']),
                                 Date.parse(i['invoice']['due_date']),
                                 i['invoice']['total_amount'],
                                 i['invoice']['currency'],
                                 Date.parse(i['invoice']['issue_date'])
        )
      end
      invoices
    rescue
      {}
    end

    def invoice(id)
      i = get("/invoices/#{id}.json").parsed_response
      BillApp::Invoice.new(i['invoice']['id'],
                  i['invoice']['number'],
                  contact(i['invoice']['client_id']),
                  Date.parse(i['invoice']['due_date']),
                  i['invoice']['total_amount'],
                  i['invoice']['currency'],
                  Date.parse(i['invoice']['issue_date']),
                  i['invoice']['lines'].collect do |l|
                    BillApp::Line.new(l['description'],
                                      l['quantity'],
                                      l['unit_price'],
                                      l['id']
                    )
                  end
      )
    rescue
      nil
    end

    def contact(id)
      c = get("/contacts/#{id}.json").parsed_response
      Contact.new(c['contact']['id'],
                  c['contact']['full-name'],
                  c['contact']['company'],
                  c['contact']['email']
      )
    rescue
      nil
    end

    private
    def get(resource)
      uri = URI(@agenda)
      HTTParty.get(uri.scheme+'://'+uri.hostname+':'+
                       uri.port.to_s+resource,
                   basic_auth: { username: @email,
                                 password: @password })
    end
  end
end
