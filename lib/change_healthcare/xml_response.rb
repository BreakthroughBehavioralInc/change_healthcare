module ChangeHealthcare
  class XmlResponse
    attr_reader :xml, :response
    def initialize(response)
      @response = response
      @xml = Nokogiri::XML(response.body)
    end

    def method_missing(m, *args, &block)
      response.send(m, *args, &block)
    end
  end
end
