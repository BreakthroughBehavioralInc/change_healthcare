require 'spec_helper'

RSpec.describe ChangeHealthcare::BaseApiObject, :vcr do
  describe ".attributes" do
    it "Raises an error if not implemented" do
      expect{ChangeHealthcare::BaseApiObject.attributes}.to raise_error "Not Implemented"
    end
  end

  describe ".chc_object_name" do
    it "Raises an error if not implemented" do
      expect{ChangeHealthcare::BaseApiObject.chc_object_name}.to raise_error "Not Implemented"
    end
  end
end
