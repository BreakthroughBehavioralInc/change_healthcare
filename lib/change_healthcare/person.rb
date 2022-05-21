# https://cli-cert.emdeon.com/api/cert/person.html
class ChangeHealthcare::Person < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :address_1, :address_2, :age, :age_type, :allergy_status, :bill_type,
      :birth_date, :city, :country, :county, :date, :fav_pharm_name,
      :favorite_pharmacy, :first_name, :formu_groupid, :formu_orgid,
      :guarantor, :height, :home_phone_area_code, :home_phone_number,
      :hsi_value, :hsilabel, :insurance, :is_active, :isp_address_1,
      :isp_city, :isp_hsi_value, :isp_name, :isp_state, :isp_zip, :lab,
      :lab_name, :label_name, :last_name, :last_name_soundex, :leadperson,
      :middle_name, :mother_name, :mothers_maiden_name, :name_prefix,
      :organization, :payer_identifier, :person, :person_hsi, :placer_order_number,
      :plan_identifier, :prim_cg_fname, :prim_cg_lname, :prim_cg_mname,
      :primarycaregiver, :providercaregiver, :record_date, :sec_insurance,
      :sec_isp_address_1, :sec_isp_city, :sec_isp_hsi_value, :sec_isp_name,
      :sec_isp_state, :sec_isp_zip, :sex, :soundex_flag, :ssn, :state, :status,
      :suffix, :ter_insurance, :ter_isp_address_1, :ter_isp_city, :ter_isp_hsi_value,
      :ter_isp_name, :ter_isp_state, :ter_isp_zip, :title, :transmission_mode, :weight,
      :work_phone_area_code, :work_phone_ext, :work_phone_number, :zip
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "person"
  end

  # https://cli-cert.emdeon.com/api/cert/person.html#search_hsi
  # Search by patient id
  # params = {hsi_value: "PATIENT_ID"}
  def self.search_hsi(params={})
    resp = call_api(__method__.to_s, params, true)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/person.html#put_partial
  # Create Patient
  # params = {birth_date: "10/27/1924", first_name: "Florence",
  #           last_name: "Edwards", middle_name: "E", address_1: "2401 N Abram Rd 85",
  #           city: "Mission", state: "TX", sex: "F", zip: "78572", hsi_value: "955001",
  #           hsilabel: "7930723", home_phone_area_code: "956", home_phone_number: "5856449"}
  def self.put_partial(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end
end
