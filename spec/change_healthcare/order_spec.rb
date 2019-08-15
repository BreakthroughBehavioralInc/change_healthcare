require 'spec_helper'

RSpec.describe ChangeHealthcare::Order do
  describe ".generate_order_number" do
    it "Retrieves the next requisition number for the lab" do
      resp = ChangeHealthcare::Order.generate_order_number({ lab: "23402537", orderingorganization: "23402521" })

      expect(resp.first).to be_a_kind_of(ChangeHealthcare::Order)
      expect(resp.first.placer_order_number).not_to be_nil
    end
  end

  describe ".search_by_order_info" do
    it "Retrieves the next requisition number for the lab" do
      mdl_config
      resp = ChangeHealthcare::Order.search_by_order_info({ placer_order_number: "76047", orderingorganization: "3004115375" })

      expect(resp.first).to be_a_kind_of(ChangeHealthcare::Order)
      expect(resp.first.first_name).not_to be_nil
    end
  end


end
