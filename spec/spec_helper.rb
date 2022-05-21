require 'simplecov'
SimpleCov.start

require "bundler/setup"
require "change_healthcare"
require "vcr"
require "pry"

ChangeHealthcare.configure do |c|
  c.base_url = "https://cli-cert.emdeon.com/servlet/XMLServlet"
  c.portal_url = "https://cli-cert.changehealthcare.com/servlet/DxLogin"
  c.user_id = ENV['USER_ID']||"USER_ID"
  c.password = ENV['PASSWORD']||"PASSWORD"
  c.facility = ENV['FACILITY']||"FACILITY"
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.filter_sensitive_data("USER_ID") { ENV['USER_ID'] }
  c.filter_sensitive_data("PASSWORD") { ENV['PASSWORD'] }
  c.filter_sensitive_data("FACILITY") { ENV['FACILITY'] }
  c.default_cassette_options = {
    :record => :once,
    :record_on_error => false,
    :match_requests_on => [:method, :uri]
  }
  c.configure_rspec_metadata!
end
