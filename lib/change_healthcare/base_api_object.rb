class ChangeHealthcare::BaseApiObject
  def self.attributes
    raise "Not Implemented"
  end

  def self.chc_object_name
    raise "Not Implemented"
  end

  def initialize(hash)
    hash.extract!(*self.class.attributes.map{|a|a.to_s}).each_pair {|k,v| public_send("#{k}=",v)}
  end

  def self.configuration
    ChangeHealthcare.configuration
  end

  private

  def self.call_api(name, params={}, include_organization = true)
    ChangeHealthcare::ApiClient.instance.call(chc_object_name, name, params, include_organization)
  end

  def self.response_to_list(resp)
    resp.xml.root.children.map {|node| new(Hash.from_xml(node.to_s)["OBJECT"])}
  end
end
