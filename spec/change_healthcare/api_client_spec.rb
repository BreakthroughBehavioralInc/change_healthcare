require 'spec_helper'

RSpec.describe ChangeHealthcare::ApiClient, :vcr do
  let(:subject) { ChangeHealthcare::ApiClient.instance }

  describe "#call" do
    it "calls the endpoint provided" do
      resp = subject.call('providercaregiver', 'search_provcg_and_cgpref' )

      expect(resp.code).to eq(200)

      expect(resp.xml).to be_kind_of(Nokogiri::XML::Document)
      expect(resp.xml.root.children).not_to be_empty

      expect(resp.body).to be_kind_of(String)
      expect(resp.body).not_to be_empty
    end

    it "raises an Error if the call fails" do
      expect{subject.call('providercaregiver', 'search_provcg_and_cgpref', {}, false )}.to raise_error(ChangeHealthcare::Error)

    end
  end
end
