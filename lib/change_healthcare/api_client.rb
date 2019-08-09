class ChangeHealthcare::ApiClient
  include Singleton
  attr_reader :session_id

  def call(object_name, operation, params = {}, session_id = nil)
    xml = build_xml(object_name, operation, params, session_id)
    do_request "#{configuration.base_url}?request=#{xml}"
  end

  def configuration
    ChangeHealthcare.configuration
  end

  private

  # https://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Builder
  def build_xml(object_name, operation, params, session_id)
    request_params = base_request_params
    request_params[:sessionid] = session_id unless session_id == nil

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.REQUEST(request_params) do
        xml.OBJECT(name: object_name, op: operation) do
          params.each_pair do |k,v|
            xml.send(k, v)
          end
          xml.organization configuration.facility
        end
      end
    end
    builder.to_xml
  end

  def base_request_params
    {
      userid: configuration.user_id,
      password: configuration.password,
      facility: configuration.facility
    }
  end

  def do_request(url)
    response = ChangeHealthcare::XmlResponse.new(RestClient.get(url))
    doc = response.xml
    @session_id = doc.root.attributes["sessionid"].value if doc.root.attributes.keys.include?("sessionid")
    response
  end
end
