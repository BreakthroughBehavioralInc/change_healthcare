require "rest_client"
require "nokogiri"

require "active_support"
require 'active_support/core_ext'

require "singleton"
require "change_healthcare/version"
require "change_healthcare/xml_response"
require "change_healthcare/api_client"
require "change_healthcare/base_api_object"
require "change_healthcare/provider_caregiver"
require "change_healthcare/organization_lab"

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
