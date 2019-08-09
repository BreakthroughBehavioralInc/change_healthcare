# https://cli-cert.emdeon.com/api/cert/organizationlab.htm
class ChangeHealthcare::OrganizationLab < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :address_1, :address_2, :can_order_thru, :city, :clia_number,
      :discrete_result, :enable_irbcl, :is_beacon, :is_default,
      :lab, :lab_code, :lab_name, :organization, :organizationlab,
      :parent_lab_code, :parent_lab_name, :parentlab, :payer_priority,
      :sequence, :state, :transfer_id, :transmission_mode, :zip
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
  "organizationlab"
  end

  #https://cli-cert.emdeon.com/api/cert/organizationlab.html#search_orderable_labs
  #sample params: {can_order_thru: "Y", child_only: "Y"}
  def self.search_orderable_labs(params={})
    resp = call_api(__method__.to_s, params)
    response_to_list(resp)
  end
end
