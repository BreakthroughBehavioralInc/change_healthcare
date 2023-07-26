# https://cli-cert.emdeon.com/api/cert/insurance.html
class ChangeHealthcare::Insurance < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :person, :isp, :insurance, :group_number, :organization,
      :insured_last_name, :insured_first_name, :insured_address_1,
      :insured_city, :insured_state, :insured_zip, :insured_sex,
      :insured_birth_date, :insured_home_phone_number
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "insurance"
  end

  # https://cli-cert.emdeon.com/api/cert/insurance.html#put
  # params = {person: 3006594591, isp: 3004227330, group_number: 123456
  #    insured_last_name: "Baker", insured_first_name: "Flo", 
  #    insured_address_1: "16713 Moonshadow Ln", insured_city: "Lutz", 
  #    insured_state: "FL", insured_zip: "33558-4809", insured_sex: "F",
  #    insured_birth_date: "11/21/1954", insured_home_phone_number: 123456789}
  def self.put(params={})
    resp = call_api(__method__.to_s, params, true)
    response_to_list(resp)
  end
end
