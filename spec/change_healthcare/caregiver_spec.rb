require 'spec_helper'

RSpec.describe ChangeHealthcare::Caregiver do
  describe ".search" do
    it "Returns the list of existing caregivers" do
      resp = ChangeHealthcare::Caregiver.search({npi: "1877324149"})
      expect(resp.first).to be_a_kind_of(ChangeHealthcare::Caregiver)
      expect(resp.first.caregiver).not_to be_nil
      expect(resp.first.last_name).not_to be_nil
    end

    context "with unknown npi" do
      it "returns empty" do
        resp = ChangeHealthcare::Caregiver.search({npi: "1"})
      expect(resp).to be_empty
      end
    end
  end
end
