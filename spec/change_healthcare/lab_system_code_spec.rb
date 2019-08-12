require 'spec_helper'

RSpec.describe ChangeHealthcare::LabSystemCode do
  describe ".search_uniq_codes" do
    xit " Used with code_type=ORD_CATEG in combination with lab objid to retrieve a list of order categories used by the lab" do
      resp = ChangeHealthcare::LabSystemCode.search_uniq_codes({lab: 23402537, code_type: "ORD_CATEG"})

      expect(resp.first).to be_a_kind_of(ChangeHealthcare::LabSystemCode)
      expect(resp.first.system_code).not_to be_nil
    end
  end
end
