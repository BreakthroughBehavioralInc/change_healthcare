# https://cli-cert.emdeon.com/api/cert/guarantor.html
class ChangeHealthcare::Guarantor < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :person, :address_1, :city, :state, :zip, :last_name, :first_name,
      :guarantor_sex, :relationship, :home_phone
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "guarantor"
  end

  # https://cli-cert.emdeon.com/api/cert/guarantor.html#put_partial
  # params = {person: 3006594591, address_1: "Test 2 Marine Way", city: "Juneau", 
  #           state: "FL", zip: "33558", last_name: "pcppatient132", first_name: "test",
  #           guarantor_sex: "F", relationship: 18, home_phone: 8139628668}
  def self.put_partial(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/guarantor.html#search
  # params = {person: 3006594591, address_1: "Test 2 Marine Way", city: "Juneau", 
  #           state: "FL", zip: "33558", last_name: "pcppatient132", first_name: "test",
  #           guarantor_sex: "F", relationship: 18, home_phone: 8139628668}
  def self.search(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end
end
