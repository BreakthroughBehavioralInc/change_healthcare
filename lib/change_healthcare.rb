require "rest_client"
require "nokogiri"
require "change_healthcare/version"
require "./lib/change_healthcare/xml_response"
require "./lib/change_healthcare/api_client"

module ChangeHealthcare
  class Error < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
    configuration
  end

  class Configuration
    attr_accessor :base_url, :user_id, :password, :facility
  end
end
