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
               /https:\/\/joe\d%40example.com:joesthebest@joe\d.billapp.cz\//).
        to_return(:status => 200, :body => "", :headers => {})
  end
end

Capybara.javascript_driver = :poltergeist

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')
