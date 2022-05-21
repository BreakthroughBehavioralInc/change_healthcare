require 'spec_helper'

RSpec.describe ChangeHealthcare::HsiLabel, :vcr do
  describe ".search" do
    it "Returns the list of existing hsi labels based on the parameters" do
      resp = ChangeHealthcare::HsiLabel.search({is_hsi_for: "PATIENT", registration: "Y"})
      expect(resp.first).to be_a_kind_of(ChangeHealthcare::HsiLabel)
      expect(resp.first.hsilabel).not_to be_nil
    end
  end
end
