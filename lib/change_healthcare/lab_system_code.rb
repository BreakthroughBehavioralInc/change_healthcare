# https://cli-cert.emdeon.com/api/cert/labsystemcode.html
class ChangeHealthcare::LabSystemCode < ChangeHealthcare::BaseApiObject
  def self.attributes
    [ :code_type, :lab, :lab_system_code, :system_code ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "labsystemcode"
  end

  # https://cli-cert.emdeon.com/api/cert/labsystemcode.html#search_uniq_codes
  # params = {lab: 23402537, code_type: "ORD_CATEG"}
  def self.search_uniq_codes(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end
end
