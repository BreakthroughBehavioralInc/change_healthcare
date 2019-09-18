require 'spec_helper'

RSpec.describe ChangeHealthcare::Report do

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
      ChangeHealthcare::Report.download_reports(params) do | data |
        expect(data[:report_unique_id]).not_to be_empty
        binding.pry
        break #just checking one result
      end
    end
  end

  describe ".search_downloadable_reports" do
    let(:expected_response) do
      "https://cli-cert.changehealthcare.com/servlet/DxLogin?CreationDateFrom=03%2F01%2F2014&CreationDateTo=03%2F08%2F2014&EMR=y&PW=Welcome123&actionCommand=startDownload&apiLogin=true&autoPrint=true&batchDownload=true&hdnBusiness=23402521&reportTypes=LABRES&target=jsp%2Flab%2Fresults%2FFDC.jsp&userid=api_user"
    end

    it "Returns the link" do
      resp = ChangeHealthcare::Report.search_downloadable_reports(params)
      expect(resp).to eq(expected_response)
    end
  end

  describe ".number_of_files_to_download" do
    let(:expected_response) do
      "https://cli-cert.changehealthcare.com/servlet/lab.results.fdcServlet?actionCommand=NextFile&batchDownload=true&fdcuserid=api_user"
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
        "https://cli-cert.changehealthcare.com/servlet/lab.results.fdcServlet?actionCommand=#{action}&fdcuserid=api_user"
      end

      it "Returns the link" do
        resp = ChangeHealthcare::Report.send(method)
        expect(resp).to eq(expected_response)
      end
    end
  end
end
