# https://cli-cert.emdeon.com/api/cert/isp.html
class ChangeHealthcare::Isp < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :name, :address1, :city, :state, :zip, :hsi_value, :isp_type, :isp,
      :organization
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "isp"
  end

  # https://cli-cert.emdeon.com/api/cert/isp.html#add
  # params = {name: "BCBSIL", address_1: "10 ST NORTH BCBSIL", city: "Miami", state: "FL", zip: "33018"}
  def self.add(params={})
    resp = call_api(__method__.to_s, params, true)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/isp.html#search_gui_admin
  # params = {address_1: "10 ST NORTH BCBSIL", city: "Miami", state: "FL", zip: "33018"}
  def self.search_gui_admin(params={})
    resp = call_api(__method__.to_s, params, true)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/isp.html#search_by_hsi
  # params = {hsi_value: "BCBSIL"}
  def self.search_by_hsi(params={})
    resp = call_api(__method__.to_s, params, true)
    response_to_list(resp)
  end
end
