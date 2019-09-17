# https://cli-cert.emdeon.com/api/cert/order.html
class ChangeHealthcare::Order < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :actalink_user_name, :age, :age_type, :anonymous_flag, :aoe_validation_failed,
      :beacon_case_number, :bed, :bill_type, :billingcaregiver, :cached_requisition,
      :callback_phone_area_code, :callback_phone_number, :cg_first_name, :cg_last_name,
      :cg_middle_name, :collection_datetime, :created_by, :date, :description, :document,
      :expected_coll_datetime, :fasting_hours, :faxback_phone_area_code, :faxback_phone_number,
      :first_name, :guarantor, :guarantor_address_1, :guarantor_address_2, :guarantor_city,
      :guarantor_first_name, :guarantor_home_phone, :guarantor_last_name, :guarantor_middle_name,
      :guarantor_relationship, :guarantor_sex, :guarantor_state, :guarantor_suffix, :guarantor_zip,
      :home_phone_area_code, :home_phone_number, :hospital_id, :hsilabel, :icd_10_cm_code,
      :icd_9_cm_code, :icd_lab_accepts, :icd_validation_failed, :include_in_manifest,
      :is_split, :lab, :lab_instruction, :lab_logo_location, :lab_name, :lab_reference,
      :last_name, :master_placer_order_number, :middle_name, :nurse_unit, :order, :order_code,
      :order_comment, :order_diag_description, :order_status, :order_type, :ordering_cg_id,
      :orderingorganization, :organization_counter, :orig_organization_name, :originalorder,
      :origorderingorganization, :pan_indicator, :parentorder, :patient_id, :person,
      :person_address_1, :person_address_2, :person_city, :person_dob, :person_first_name,
      :person_home_phone_area_code, :person_home_phone_number, :person_hsi_value,
      :person_last_name, :person_middle_name, :person_sex, :person_ssn, :person_state,
      :person_suffix, :person_zip, :personhsi, :phone_result_flag, :placer_order_number,
      :prepaid_amount, :primaryorderingcaregiver, :ref_cg_fname, :ref_cg_lname, :ref_cg_mname,
      :ref_cg_npi, :ref_cg_suffix, :ref_cg_upin, :referring_cg_id, :referringcaregiver,
      :request_date, :room, :seconds_since_transmit, :sex, :stat_flag, :submission_date,
      :suffix, :transmission_date, :username, :work_phone_area_code, :work_phone_ext, :work_phone_number
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "order"
  end

  # https://cli-cert.emdeon.com/api/cert/order.html#generate_order_number
  # params = { lab: "1502191", orderingorganization: "3004115375" }
  def self.generate_order_number(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/order.html#search_by_order_info
  # params = { placer_order_number: "76047", orderingorganization: "3004115375" }
  def self.search_by_order_info(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/order.html#get
  # params = { order: "3004834610" }
  def self.get(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  def self.e_order_summary_link(params)
    base = {
      "userid" => configuration.user_id,
      "PW" => configuration.password,
      "hdnBusiness" => configuration.facility,
      "target" => "jsp/lab/order/ESummaryOrder.jsp",
      "actionCommand" => "EOrderSummary",
      "summary" => "true",
      "apilogon" => "true",
    }
    params.merge!(base)

    return "#{configuration.portal_url}?#{params.to_query}"
  end


  #{order_id: XXXXXXXXXXX}
  def self.e_order_html_link(params)
    base = {
      "userid" => configuration.user_id,
      "PW" => configuration.password,
      "hdnBusiness" => configuration.facility,
      "apiLogin" => "true",
      "target" => "servlet/servlets.apiOrderServlet?",
      "actionCommand" => "print",
      "apiuserid" => configuration.user_id
    }
    params.merge!(base)
    return "#{configuration.portal_url}?#{params.to_query}"
  end
end
