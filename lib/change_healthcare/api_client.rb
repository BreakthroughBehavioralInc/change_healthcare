class ChangeHealthcare::ApiClient
  include Singleton
  attr_reader :session_id

  def call(object_name, operation, params = {}, include_organization = true, session_id = nil)
    xml = build_xml(object_name, operation, params, include_organization, session_id)
    pp xml
    do_request "#{configuration.base_url}?request=#{xml}"
  end

  def configuration
    ChangeHealthcare.configuration
  end

  private

  # https://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Builder
  def build_xml(object_name, operation, params, include_organization, session_id)
    request_params = base_request_params
    request_params[:sessionid] = session_id unless session_id == nil

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.REQUEST(request_params) do
        if params.is_a? Hash
          xml.OBJECT(name: object_name, op: operation) do
            params.each_pair do |k,v|
              xml.send(k, v)
            end
            xml.organization configuration.facility if include_organization
          end
        elsif params.is_a? Array
          params.each do |element|
            xml.OBJECT(name: object_name, op: operation) do
              element.each_pair do |k,v|
                xml.send(k, v)
              end
            end
          end

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
    raise ChangeHealthcare::Error.new(doc.root) if doc.children[0].name == "ERROR"
    @session_id = doc.root.attributes["sessionid"].value if doc.root.attributes.keys.include?("sessionid")
    response
  end
end
