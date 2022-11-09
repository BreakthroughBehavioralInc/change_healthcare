# https://cli-cert.emdeon.com/api/cert/pharmacy.html
class ChangeHealthcare::Pharmacy < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :address_1, :address_2, :city, :email, :fax, :is_active, :is_electronic,
      :is_epcs_capable, :name, :npi, :pharmacy_id, :pharmacy_type, :phone,
      :ppi_level3_id, :script_version, :service_levels, :state,
      :supports_newrx, :supports_refreq, :supports_rxcancel, :supports_rxchange,
      :supports_rxfill, :zip
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "pharmacy"
  end

  def self.get(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  def self.search(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end
end
