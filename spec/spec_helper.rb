require "bundler/setup"
require "change_healthcare"
require 'pry'
require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  config.before(:each) do
    ChangeHealthcare.configure do |c|
      c.base_url = "https://cli-cert.emdeon.com/servlet/XMLServlet"
      c.user_id = "api_user"
      c.password = "Welcome123"
      c.facility = "23402521"
    end
  end
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
