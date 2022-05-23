# https://cli-cert.emdeon.com/api/cert/clinicalreport.html
class ChangeHealthcare::ClinicalReport < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :abnormals_count, :clinicalreport, :content_expiration_date, :creation_date, :creation_datetime, :document,
      :expiration_date, :filler_order_number, :forwarded, :has_external_content, :is_abnormal, :is_annotated,
      :is_downloaded, :is_forwarded, :is_latest, :is_printed, :is_viewed, :lab_code, :ordering_cg_fname,
      :ordering_cg_lname, :ordering_cg_mname, :ordering_cg_suffix, :ordering_client_id, :orderresult, :orders_transmitted,
      :organization_name, :originalreport, :person, :person_account_number, :person_first_name, :person_last_name,
      :person_middle_name, :person_suffix, :placer_order_number, :previousreport, :psc_orders_created, :receiving_cg_fname,
      :receiving_cg_lname, :receiving_cg_mname, :receiving_cg_suffix, :receiving_client_id, :receivingorganization,
      :report_priority, :report_request_date, :report_service_date, :report_status, :report_subject, :report_type,
      :reports_count, :reports_delivered, :reports_forwarded, :reports_printed, :reports_undelivered, :reports_viewed,
      :sequence, :sponsor, :sponsor_name, :std_orders_created
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "clinicalreport"
  end

  # https://cli-cert.emdeon.com/api/cert/order.html#get
  # params = { order: "3004834610" }
  def self.get(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  def self.search_filedelivery(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end
end
