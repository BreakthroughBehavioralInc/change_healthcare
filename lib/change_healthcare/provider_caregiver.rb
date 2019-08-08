# https://cli-cert.emdeon.com/api/cert/providercaregiver.htm
class ChangeHealthcare::ProviderCaregiver
  ATTRS = [
    :appuser, :reference, :caregiver, :caregiver_type,
    :cg_birth_date, :cg_dea_number, :cg_first_name,
    :cg_is_epcs_enabled, :cg_last_name, :cg_middle_name,
    :cg_npi, :cg_patmsg_id, :cg_prefix, :cg_sex,:cg_ssn,
    :cg_suffix, :cg_type, :cg_upin, :dea_number, :enable_epcs,
    :enable_refill, :is_active, :is_erx_registered, :organization,
    :provider, :provider_address_1, :provider_city, :provider_fed_tax_id,
    :provider_name, :provider_npi, :provider_state, :provider_type,
    :provider_zip, :providercaregiver, :toggle_epcs_for_approval, :update
  ]

  attr_accessor(*ATTRS)

  CHC_OBJECT_NAME = "providercaregiver"

  def initialize(hash)
    hash.extract!(*ATTRS.map{|a|a.to_s}).each_pair {|k,v| public_send("#{k}=",v)}
  end

  # https://cli-cert.emdeon.com/api/cert/providercaregiver.html#search_provcg_and_cgpref
  def self.search_provcg_and_cgpref
    resp = ChangeHealthcare::ApiClient.instance.call(CHC_OBJECT_NAME, __method__.to_s)

    resp.xml.root.children.map {|node| new(Hash.from_xml(node.to_s)["OBJECT"])}
  end
end
