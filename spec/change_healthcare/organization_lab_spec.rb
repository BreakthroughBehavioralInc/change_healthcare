require 'spec_helper'

RSpec.describe ChangeHealthcare::OrganizationLab, :vcr do
  describe ".search_orderable_labs" do
    it "Retrieve list of orderable labs associated with site" do
      resp = ChangeHealthcare::OrganizationLab.search_orderable_labs({can_order_thru: "Y", child_only: "Y"})

      expect(resp.first).to be_a_kind_of(ChangeHealthcare::OrganizationLab)
      expect(resp.first.organizationlab).not_to be_nil
      expect(resp.first.zip).not_to be_nil
    end
  end
end
