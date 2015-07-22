require 'simplecov'
require 'webmock/rspec'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'capybara/poltergeist'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.fail_fast = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.use_transactional_fixtures = false

  config.include Devise::TestHelpers, type: :controller

  config.before(:each) do
    stub_request(:get,
          /https:\/\/joe\d+%40example.com:joesthebest@joe\d+.billapp.cz\/(|invoices\.json)$/).
        to_return(:status => 200, :body => "", :headers => {'Content-Type' => 'application/json'})
    stub_request(:get, /https:\/\/joe\d+%40example.com:joesthebest@joe\d+.billapp.cz\/(invoices\/\d+\.json)$/).
        to_return(:status => 200, :body => '{"invoice":{"account_id":7203,"client_id":60647,"created_at":"2015-07-21T10:14:05+02:00","currency":"CZK","due_date":"2015-07-31","has_vat":false,"id":110923,"issue_date":"2015-07-21","notes":"","number":"201500003","paid_on":null,"status":"draft","tax_amount":0.0,"total_amount":10000.0,"updated_at":"2015-07-21T10:14:05+02:00","lines":[{"description":"Skolenie bezpecnosti webu","item_id":null,"quantity":1.0,"unit_price":10000.0,"vat":0.0}]}}', :headers => {'Content-Type' => 'application/json'})
    stub_request(:get, /https:\/\/joe\d+%40example.com:joesthebest@joe\d+.billapp.cz\/(contacts\/\d+\.json)$/).
        to_return(:status => 200, :body => '{"contact":{"city":"Praha 1","company":"Uk\u00e1zkov\u00fd klient s.r.o.","country":"CZ","created_at":"2015-07-21T10:05:50+02:00","email":"ukazkovyklient@seznam.cz","full_name":null,"id":60647,"id_number":null,"notes":null,"phone_number":null,"postcode":"11000","street":"Dlouha 1","updated_at":"2015-07-21T10:05:50+02:00","vat_number":null,"web":null}}', :headers => {'Content-Type' => 'application/json'})
  end
end

Capybara.javascript_driver = :poltergeist

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')
