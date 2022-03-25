require 'spec_helper'

RSpec.describe ChangeHealthcare::ClinicalReport do
  describe ".get" do
    it "Retrieves the order based on the search params" do
      resp = ChangeHealthcare::ClinicalReport.get({ clinicalreport: "3007035774" })

      expect(resp.first).to be_a_kind_of(ChangeHealthcare::ClinicalReport)
      expect(resp.first.clinicalreport).not_to be_nil
    end
  end
end
