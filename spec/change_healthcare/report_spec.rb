require 'spec_helper'

RSpec.describe ChangeHealthcare::Report, :vcr do
  let(:password){ ChangeHealthcare.configuration.password }
  let(:user_id){ ChangeHealthcare.configuration.user_id }
  let(:facility){ ChangeHealthcare.configuration.facility }
  
  let(:params) do
    {
      "reportTypes" => "LABRES",
      "EMR" => "y",
      "autoPrint" => "true",
      "batchDownload" => "true",
      "CreationDateFrom" => "03/01/2014",
      "CreationDateTo" => "03/08/2014"
    }
  end

  describe ".download_reports" do
    it "Downloads the results" do
      counter = 0
      ChangeHealthcare::Report.download_reports(params) do | data |
        expect(data[:report_unique_id]).not_to be_empty

        break if counter == 2 #just checking one result
        counter +=1
      end
    end
  end

  describe ".search_downloadable_reports" do
    let(:expected_response) do
      "https://cli-cert.changehealthcare.com/servlet/DxLogin?CreationDateFrom=03%2F01%2F2014&CreationDateTo=03%2F08%2F2014&EMR=y&PW=#{password}&actionCommand=startDownload&apiLogin=true&autoPrint=true&batchDownload=true&hdnBusiness=#{facility}&reportTypes=LABRES&target=jsp%2Flab%2Fresults%2FFDC.jsp&userid=#{user_id}"
    end

    it "Returns the link" do
      resp = ChangeHealthcare::Report.search_downloadable_reports(params)
      expect(resp).to eq(expected_response)
    end
  end

  describe ".number_of_files_to_download" do
    let(:expected_response) do
      "https://cli-cert.changehealthcare.com/servlet/lab.results.fdcServlet?actionCommand=NextFile&batchDownload=true&fdcuserid=#{user_id}"
    end

    it "Returns the link" do
      resp = ChangeHealthcare::Report.number_of_files_to_download
      expect(resp).to eq(expected_response)
    end
  end

  [
    ["retrieve_document_information", "GetFileInfo"],
    ["download_document", "DownloadFile"],
    ["mark_as_downloaded", "MarkAsDownloaded"]
  ].each do |method, action|
    describe ".#{method}" do
      let(:expected_response) do
        "https://cli-cert.changehealthcare.com/servlet/lab.results.fdcServlet?actionCommand=#{action}&fdcuserid=#{user_id}"
      end

      it "Returns the link" do
        resp = ChangeHealthcare::Report.send(method)
        expect(resp).to eq(expected_response)
      end
    end
  end
end
