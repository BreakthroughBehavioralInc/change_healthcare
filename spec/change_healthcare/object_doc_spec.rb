require 'spec_helper'

RSpec.describe ChangeHealthcare::ObjectDoc do
  describe ".search" do
    it "Retrieve list of objectdocs" do
      resp = ChangeHealthcare::ObjectDoc.search({object_id:  "3004834601"})
      expect(resp[0].object_type).to eq("order")
    end
  end

  describe ".get" do
    it "Retrieve the specified objectdoc" do
      resp = ChangeHealthcare::ObjectDoc.get(objectdoc:  "621448196359963")
      expect(resp[0].body_text).not_to be_nil
    end
  end
end
