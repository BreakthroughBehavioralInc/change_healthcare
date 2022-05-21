require 'spec_helper'

RSpec.describe ChangeHealthcare::LabConfig, :vcr do
  describe ".search" do
    it "Retrieve list of configurations for the lab" do
      resp = ChangeHealthcare::LabConfig.search("23402537")
      expect(resp.first).to be_a_kind_of(ChangeHealthcare::LabConfig)
      expect(resp.first.description).not_to be_nil
      expect(resp.first.is_required).not_to be_nil
    end
  end
end
