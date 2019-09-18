# Not a object on the API
class ChangeHealthcare::Report < ChangeHealthcare::BaseApiObject


  # params = {
  #             "reportTypes" => "LABRES",
  #             "EMR" => "y",
  #             "autoPrint" => "true",
  #             "batchDownload" => "true",
  #             "CreationDateFrom" => "03/01/2014",
  #             "CreationDateTo" => "03/08/2014",
  #   }
  # yields a hash with all the file data
  def self.download_reports(params)
    raise "Block needed to handle results" unless block_given?
    r1 = RestClient.get(search_downloadable_reports(params))
    cookies = r1.cookies

    loop do
      r2 = RestClient.get(number_of_files_to_download, cookies: cookies)
      #cookies = r2.cookies

      files_to_dowload_data = r2.body.match("<--BEGIN NUMBER OF DOCS>(?<data>.*)<--END NUMBER OF DOCS>")[:data]
      pp files_to_dowload_data
      pp files_to_dowload_data.split(";")
      number, error_code, report_unique_id, _ = files_to_dowload_data.split(";")
      number = number.to_i

      break if number == -1

      i=0
      while i < number do
        r3 = RestClient.get(retrieve_document_information, cookies: cookies)
        doc_info = r3.body
        doc_data = r3.body.match("<--BEGIN FILE INFO>(?<data>.*)<--END FILE INFO>")[:data]

        sponsor_name, report_type, receiving_client_id,
        account_no_last_name_first_name, document_unique_id, mime_type,
        special, request_or_service_date, sponsor_code,
        caregiver_id, account, first_name, last_name, report_service_date,
        practice_id, report_subject, report_status = doc_data.split(";")

        r4 = RestClient.get(download_document, cookies: cookies)
        doc_content = r4.body

        yield({
                report_unique_id: report_unique_id,
                document_unique_id: document_unique_id,
                last_name: last_name,
                first_name: first_name,
                sponsor_name: sponsor_name,
                report_type: report_type,
                receiving_client_id: receiving_client_id,
                account_no_last_name_first_name: account_no_last_name_first_name,
                mime_type: mime_type,
                special: special,
                request_or_service_date: request_or_service_date,
                sponsor_code: sponsor_code,
                caregiver_id: caregiver_id,
                account: account,
                report_service_date: report_service_date,
                practice_id: practice_id,
                report_subject: report_subject,
                report_status: report_status,
                doc_content: doc_content,
                cookies: cookies
              })

      i+=1
      end
    end
  end

  # params = {
  #             "reportTypes" => "LABRES",
  #             "EMR" => "y",
  #             "autoPrint" => "true",
  #             "batchDownload" => "true",
  #             "CreationDateFrom" => "03/01/2014",
  #             "CreationDateTo" => "03/08/2014",
  #   }
  def self.search_downloadable_reports(params)
    base = {
      "userid" => configuration.user_id,
      "PW" => configuration.password,
      "hdnBusiness" => configuration.facility,
      "apiLogin" => "true",
      "target" => "jsp/lab/results/FDC.jsp",
      "actionCommand" => "startDownload"
    }
    params.merge!(base)

    return "#{configuration.portal_url}?#{params.to_query}"
  end

  # Needs to be chained through session to previous call
  def self.number_of_files_to_download
    params = {
      "actionCommand" => "NextFile",
      "batchDownload" => "true",
      "fdcuserid" => configuration.user_id
    }
    return "#{lab_portal_url}?#{params.to_query}"
  end

  # Needs to be chained through session to previous call
  def self.retrieve_document_information
    params = {
      "actionCommand" => "GetFileInfo",
      "fdcuserid" => configuration.user_id
    }
    return "#{lab_portal_url}?#{params.to_query}"
  end

  # Needs to be chained through session to previous call
  def self.download_document
    params = {
      "actionCommand" => "DownloadFile",
      "fdcuserid" => configuration.user_id
    }
    return "#{lab_portal_url}?#{params.to_query}"
  end


  # Needs to be chained through session to previous call
  def self.mark_as_downloaded
    params = {
      "actionCommand" => "MarkAsDownloaded",
      "fdcuserid" => configuration.user_id
    }
    return "#{lab_portal_url}?#{params.to_query}"
  end

  private

  def self.lab_portal_url
    path = configuration.portal_url.dup
    path["DxLogin"] = "lab.results.fdcServlet"
    path
  end
end
