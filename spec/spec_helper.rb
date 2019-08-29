require 'simplecov'
SimpleCov.start

require "bundler/setup"
require "change_healthcare"
require 'pry'

SimpleCov.minimum_coverage 100

RSpec.configure do |config|
  config.before(:each) do
    ChangeHealthcare.configure do |c|
      c.base_url = "https://cli-cert.emdeon.com/servlet/XMLServlet"
      c.portal_url = "https://cli-cert.changehealthcare.com/servlet/DxLogin"
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



def mdl_config
  ChangeHealthcare.configure do |c|
    c.base_url = "https://cli-cert.emdeon.com/servlet/XMLServlet"
    c.portal_url = "https://cli-cert.changehealthcare.com/servlet/DxLogin"
    c.user_id = "p_mdlive1"
    c.password = "practice00"
    c.facility = "3004115375"
  end
end
