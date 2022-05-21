# https://cli-cert.emdeon.com/api/cert/clientid.html
class ChangeHealthcare::ClientId < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :caregiver, :caregiver_type, :clientid, :deliver_report, :description,
      :file_delivery_cfg, :first_name, :id_value, :is_active, :is_default, :lab,
      :lab_name, :last_name, :middle_name, :provider, :provider_name, :providercaregiver,
      :sex, :suffix, :upin
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "clientid"
  end

  # https://cli-cert.emdeon.com/api/cert/clientid.html#search_orglab
  # params = {lab: "23402537", provider: "23402521", is_active: "Y"}
  def self.search_orglab(params={})
    resp = call_api(__method__.to_s, params)
    response_to_list(resp)
  end
end
