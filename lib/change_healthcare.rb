require "rest_client"
require "nokogiri"

require "active_support"
require 'active_support/core_ext'
require 'require_all'
require "singleton"

require_all 'lib/**/*.rb'

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
