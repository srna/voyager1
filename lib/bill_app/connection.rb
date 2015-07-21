require 'net/http'

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
  end
end
