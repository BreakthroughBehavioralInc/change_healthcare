# https://cli-cert.emdeon.com/api/cert/hsilabel.html
class ChangeHealthcare::HsiLabel < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :description, :hsilabel, :is_hsi_for, :label_name, :object_type,
      :organization, :registration
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "hsilabel"
  end

  # https://cli-cert.emdeon.com/api/cert/hsilabel.html#search
  # params = {is_hsi_for: "PATIENT", registration: "Y"}
  def self.search(params={})
    resp = call_api(__method__.to_s, params, true)
    response_to_list(resp)
  end
end
