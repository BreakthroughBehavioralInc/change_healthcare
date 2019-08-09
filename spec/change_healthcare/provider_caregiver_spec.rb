require 'spec_helper'

RSpec.describe ChangeHealthcare::ProviderCaregiver do
  describe ".search_provcg_and_cgpref" do
    it "Returns the list of provider caregivers for the facility" do
      resp = ChangeHealthcare::ProviderCaregiver.search_provcg_and_cgpref
      expect(resp.first).to be_a_kind_of(ChangeHealthcare::ProviderCaregiver)
      expect(resp.first.caregiver).not_to be_nil
      expect(resp.first.cg_last_name).not_to be_nil
    end
  end
end
