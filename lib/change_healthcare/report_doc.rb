class ChangeHealthcare::ReportDoc < ChangeHealthcare::BaseApiObject
  def self.attributes
    [
      :body_text, :mime_type
    ]
  end

  attr_accessor(*self.attributes)
  def self.chc_object_name
    "reportdoc"
  end

  def self.search(params)
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end
end
