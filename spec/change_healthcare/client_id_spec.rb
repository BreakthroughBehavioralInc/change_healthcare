require 'spec_helper'

RSpec.describe ChangeHealthcare::ClientId do
  describe ".search_orglab" do
    xit " Retrieve list of client numbers to be used for the site/lab combination." do
      resp = ChangeHealthcare::ClientId.search_orglab({lab: "23402537", provider: "23402521", is_active: "Y"})

      expect(resp.first).to be_a_kind_of(ChangeHealthcare::ClientId)
      expect(resp.first.clientid).not_to be_nil
      expect(resp.first.id_value).not_to be_nil
    end
  end
end
