# https://cli-cert.emdeon.com/api/cert/caregiver.html
class ChangeHealthcare::Caregiver < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :birth_date, :caregiver, :caregiver_type, :caregiverhsi, :dea_number,
      :first_name, :hsi_value, :hsilabel, :is_epcs_enabled, :label_name,
      :last_name, :license_exp_date, :license_number, :license_state, :license_status,
      :license_type, :middle_name, :npi, :organization, :organization_name, :prefix,
      :sex, :ssn, :suffix, :title, :upin,
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "caregiver"
  end

  # https://cli-cert.emdeon.com/api/cert/caregiver.html#search
  # params = {npi: "1877324149"}
  def self.search(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/caregiver.html#put_no_update
  # params = {npi: "1684638855", last_name: "TestMDL", first_name: "TestMDL", birth_date: "1/1/1959", caregiver_type: "P"}
  def self.put_no_update(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end
end
