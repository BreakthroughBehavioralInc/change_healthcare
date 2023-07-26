require "rest_client"
require "nokogiri"

require "active_support"
require 'active_support/core_ext'
require "singleton"

require "change_healthcare/version"
require "change_healthcare/error"
require "change_healthcare/api_client"
require "change_healthcare/base_api_object"
require "change_healthcare/xml_response"
require "change_healthcare/caregiver"
require "change_healthcare/hsi_label"
require "change_healthcare/lab_system_code"
require "change_healthcare/organization_lab"
require "change_healthcare/provider_caregiver"
require "change_healthcare/client_id"
require "change_healthcare/lab_config"
require "change_healthcare/order"
require "change_healthcare/orderable_doc"
require "change_healthcare/person"
require "change_healthcare/object_doc"
require "change_healthcare/report"
require "change_healthcare/report_doc"
require "change_healthcare/clinical_report"
require "change_healthcare/servlet"
require "change_healthcare/order_diagnosis"
require "change_healthcare/rx"
require "change_healthcare/eligibility_client"
require "change_healthcare/pharmacy"
require "change_healthcare/isp"
require "change_healthcare/insurance"
require "change_healthcare/guarantor"


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
    attr_accessor :base_url, :base_api_url, :portal_url, :user_id, :password, :facility
  end
end
