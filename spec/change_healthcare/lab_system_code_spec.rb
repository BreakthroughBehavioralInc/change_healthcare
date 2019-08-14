require 'spec_helper'

RSpec.describe ChangeHealthcare::LabSystemCode do
  describe ".search_uniq_codes" do
    it " Used with code_type=ORD_CATEG in combination with lab objid to retrieve a list of order categories used by the lab" do
      resp = ChangeHealthcare::LabSystemCode.search_uniq_codes({lab: 23402537, code_type: "ORD_CATEG"})
      expect(resp).to be_empty
    end
  end
end
