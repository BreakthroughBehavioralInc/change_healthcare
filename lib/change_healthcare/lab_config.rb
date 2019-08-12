# https://cli-cert.emdeon.com/api/cert/labcfg.htm
class ChangeHealthcare::LabConfig < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :address_1, :address_2, :city, :configurable_item, :control_type,
      :control_width, :description, :domain_code_type, :is_required,
      :lab, :lab_code, :lab_name, :parent_level, :parentlab, :range,
      :sequence, :state, :transmission_mode, :validate, :validation,
      :value, :zip
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "labcfg"
  end

  # https://cli-cert.emdeon.com/api/cert/labcfg.html#search
  def self.search(lab_id)
    params = configurable_items.map{|i| {lab: lab_id, configurable_item: i} }
    resp = call_api(__method__.to_s, params)
    response_to_list(resp)
  end

  def self.configurable_items
    [
      "Max diagnoses per test",
      "Max diagnoses per requisition",
      "Show Report Comments",
      "Max tests per requisition",
      "Show Fasting Hours",
      "STAT Indicator",
      "Phone Results",
      "Copy To Functionality",
      "Max copy to per requisition",
      "Custom ABN Format",
      "Support Standard Requisitions",
      "Support PSC Requisitions",
      "Support Third Party Billing",
      "Support Client Billing",
      "Support Patient Billing"
    ]
  end
end
