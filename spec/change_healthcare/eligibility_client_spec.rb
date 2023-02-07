require 'spec_helper'

RSpec.describe ChangeHealthcare::EligibilityClient, :vcr do
	describe "#authenticate" do
		it "should return token and expires_at" do
			token, expires_at = ChangeHealthcare::EligibilityClient.authenticate(ChangeHealthcare.configure.auth_url, ChangeHealthcare.configure.client_id, ChangeHealthcare.configure.client_secret)
			expect(token).not_to be_nil
			expect(expires_at).not_to be_nil 
		end
	end
end