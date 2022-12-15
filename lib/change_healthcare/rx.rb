class ChangeHealthcare::Rx < ChangeHealthcare::BaseApiObject
    def self.attributes
    [
      :appuser, :auth_denied_by, :auth_denied_by_name, :auth_denied_date, :cg_dea_number,
      :cg_fname, :cg_is_epcs_enabled, :cg_lname, :cg_mname, :cg_npi, :cg_suffix, :cg_title,
      :change_type, :clearance, :comments, :created_by, :created_by_name, :created_by_username,
      :creation_date, :curr_date, :daw, :days_supply, :dea_code, :denial_reason, :denied,
      :digital_sig, :drug_id, :drug_label_name, :drug_name, :earliest_fill_date, :epa_refid,
      :epa_status, :formulary_status, :generic_code, :history, :icd_10_cm_code, :icd_9_cm_code,
      :included_in_log, :is_compound, :is_compound_cs, :last_fill_date, :last_modified_by,
      :modified_by_dur, :modified_by_formulary, :modified_date, :ndc, :organization,
      :original_date_written, :original_refills, :original_txn_detail, :originalrx, :ownerid,
      :patient_address_1, :patient_address_2, :patient_city, :patient_dob, :patient_fname,
      :patient_height, :patient_height_date, :patient_height_uom, :patient_hsi_value, :patient_lname,
      :patient_mname, :patient_pbm_senderid, :patient_pbm_unique_id, :patient_phone, :patient_sex,
      :patient_state, :patient_suffix, :patient_weight, :patient_weight_date, :patient_weight_uom,
      :patient_zip, :person, :ph_address_1, :ph_address_2, :ph_city, :ph_is_active, :ph_is_epcs_capable,
      :ph_name, :ph_phone, :ph_state, :ph_zip, :pharmacist_comments, :pharmacist_name, :pharmacy_discount,
      :pharmacy_id, :pharmacy_patient_id, :prescriber, :prescriber_name, :print_pending, :prior_auth_number,
      :quantity, :refill_request_priority, :refill_rx_num, :refill_send_dntf, :refill_trace_num,
      :refill_txn_init_date, :refills, :rx, :rx_cancel_type, :rx_issue_type, :rx_status, :rx_type, :rxchange,
      :rxcui, :sig, :supervising_prescriber, :thru_date, :transmission_date, :transmission_error_msg,
      :transmittal_status, :units_of_measure
    ]
  end

  attr_accessor(*attributes)

  def self.chc_object_name
    "rx"
  end

  # https://cli-cert.emdeon.com/api/cert/rx.html#search_prescriber
  # params = { organization: #{facility}, creation_date_from: "01/01/2021", rx_status: "AUTHORIZED" }
  def self.search_prescriber(params)
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/rx.html#search_patient
  # params = { organization: #{facility}, person: "123345" }
  def self.search_patient(params)
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/rx.html#search_org
  # params = { organization: #{facility}, rx_status: "AUTHORIZED" }
  # OPTIONAL {creation_date_from: "01/01/2021" }
  def self.search_org(params)
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  def self.rx_with_patient_search(params)
    base = {
      "userid" => configuration.user_id,
      "PW" => configuration.password,
      "hdnBusiness" => configuration.facility,
      "target" => "jsp/lab/person/PatientLookup.jsp",
      "actionCommand" => "Search",
      "apiLogin" => "true",
      "FromOrder" => "false",
      "FromRx" => "true",
      "loadPatient" => "false",
      "link" => "false"
    }
    params.merge!(base)

    "#{configuration.portal_url}?#{params.to_query}"
  end
end
