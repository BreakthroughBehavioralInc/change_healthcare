require 'spec_helper'

RSpec.describe ChangeHealthcare::Person do
  describe ".search_hsi" do
    it "Returns the patient based onthe hsi" do
      resp = ChangeHealthcare::Person.search_hsi({hsi_value: "test"})
      expect(resp.first).to be_a_kind_of(ChangeHealthcare::Person)
      expect(resp.first.person).not_to be_nil
    end
  end

  describe ".put_partial" do
    it "Creates a  patient" do
      params = {birth_date: "10/27/1923", first_name: "Florenc",
                last_name: "Edward", middle_name: "E", address_1: "2401 N Abram Rd 86",
                city: "Mission", state: "TX", sex: "F", zip: "78572", hsi_value: "test",
                hsilabel: "3001763753", home_phone_area_code: "956", home_phone_number: "5856449"
               }

      resp = ChangeHealthcare::Person.put_partial(params)
      expect(resp.first).to be_a_kind_of(ChangeHealthcare::Person)
      expect(resp.first.person).not_to be_nil
    end
  end
end
