require 'spec_helper'

RSpec.describe ChangeHealthcare::EligibilityClient, :vcr do
  describe "#new" do
    it "should return token and expires_at" do 
      rspec = ChangeHealthcare::EligibilityClient.instance.authenticate(AUTH_URL, CLIENT_ID, CLIENT_SECRET)
      
      expect(ChangeHealthcare::EligibilityClient.instance.token).not_to be_nil
      expect(ChangeHealthcare::EligibilityClient.instance.expires_at).not_to be_nil
    end
  end
end