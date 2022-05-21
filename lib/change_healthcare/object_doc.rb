# https://cli-cert.emdeon.com/api/cert/objectdoc.html
class ChangeHealthcare::ObjectDoc < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :body_text, :expiration_date, :mime_type, :object_id,
      :object_type, :objectdoc, :report_date, :storage_date
    ]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "objectdoc"
  end

  # https://cli-cert.emdeon.com/api/cert/objectdoc.html#search
  # params = { object_id:  "3004834601"}
  def self.search(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

  # https://cli-cert.emdeon.com/api/cert/objectdoc.html#get
  # params = { objectdoc:  "621448196359963"}
  def self.get(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end

end
