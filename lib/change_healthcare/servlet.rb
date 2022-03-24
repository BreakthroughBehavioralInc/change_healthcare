# https://cli-cert.emdeon.com/api/Change%20Healthcare%20Clinical%20Exchange%20Channel%20Partner%20API%20v2.4.pdf

module ChangeHealthcare
  class Servlet < ChangeHealthcare::BaseApiObject
    def self.attributes
      [
        :name,
        :op,
        :anonymous_flag,
        :guarantor_relationship,
        :person_sex,
        :guarantor,
        :collection_datetime,
        :ref_cg_mname,
        :guarantor_city,
        :order_status,
        :billingcaregiver,
        :work_phone_number,
        :cg_middle_name,
        :bill_type,
        :lab_name,
        :ref_cg_npi,
        :cg_first_name,
        :order,
        :prepaid_amount,
        :ref_cg_fname,
        :lab_reference,
        :stat_flag,
        :callback_phone_number,
        :include_in_manifest,
        :ownerid,
        :master_placer_order_number,
        :guarantor_suffix,
        :order_code,
        :aoe_validation_failed,
        :nurse_unit,
        :person_dob,
        :icd_lab_accepts,
        :work_phone_area_code,
        :document,
        :orderingorganization,
        :person_zip,
        :submission_date,
        :pan_indicator,
        :guarantor_last_name,
        :clearance,
        :person_ssn,
        :icd_9_cm_code,
        :person_home_phone_number,
        :sex,
        :last_name,
        :seconds_since_transmit,
        :phone_result_flag,
        :guarantor_home_phone,
        :faxback_phone_number,
        :guarantor_state,
        :lab_instruction,
        :cached_requisition,
        :person_first_name,
        :ref_cg_lname,
        :bed,
        :date,
        :person_suffix,
        :guarantor_middle_name,
        :order_comment,
        :parentorder,
        :guarantor_first_name,
        :cg_last_name,
        :lab,
        :suffix,
        :guarantor_zip,
        :lab_logo_location,
        :person_city,
        :fasting_hours,
        :person_address_1,
        :person_address_2,
        :personhsi,
        :manual_req_num,
        :transmission_date,
        :referringcaregiver,
        :icd_10_cm_code,
        :order_diag_description,
        :order_type,
        :icd_validation_failed,
        :ordering_cg_id,
        :actalink_user_name,
        :organization_counter,
        :person_home_phone_area_code,
        :person_last_name,
        :placer_order_number,
        :guarantor_address_1,
        :is_split,
        :guarantor_address_2,
        :work_phone_ext,
        :hospital_id,
        :created_by,
        :ref_cg_upin,
        :patient_id,
        :person,
        :origorderingorganization,
        :primaryorderingcaregiver,
        :person_state,
        :beacon_case_number,
        :expected_coll_datetime,
        :callback_phone_area_code,
        :age_type,
        :hsilabel,
        :referring_cg_id,
        :description,
        :ref_cg_suffix,
        :guarantor_sex,
        :person_middle_name,
        :home_phone_number,
        :first_name,
        :middle_name,
        :originalorder,
        :room,
        :faxback_phone_area_code,
        :request_date,
        :home_phone_area_code,
        :age,
        :orig_organization_name,
        :person_hsi_value,
        :username
      ]
    end

    attr_accessor(*attributes)

    def self.chc_object_name
      'servlets'
    end

    def self.api_order_servlet(params)
      resp = call_api(__method__.to_s.camelize(:lower), params)
      data_nodes = resp.xml.root.children.map {|node| Hash.from_xml(node.to_s)['OBJECT']}
      data_nodes.each_with_object({}) { |node, hsh| hsh[node['name']] = node }
    end

    class << self
      private

      def call_api(name, params = {})
        formatted_params = base_api_params.merge(params)
        response = RestClient.get(url(name, formatted_params), cookies: login.cookies)
        ChangeHealthcare::XmlResponse.new(response)
      end

      def base_api_params
        {
          apiuserid: configuration.user_id,
          actionCommand: 'xml'
        }
      end

      def login
        params = {
          userid: configuration.user_id,
          PW: configuration.password,
          hdnBusiness: configuration.facility,
          apiLogin: true,
          actionCommand: 'xml'
        }
        RestClient.get("#{configuration.portal_url}?#{params.to_query}")
      end

      def url(name, params)
        "#{configuration.base_api_url}/#{chc_object_name}.#{name}?#{params.to_query}"
      end
    end
  end
end
