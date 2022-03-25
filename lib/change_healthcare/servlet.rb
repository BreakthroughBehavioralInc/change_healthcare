# https://cli-cert.emdeon.com/api/Change%20Healthcare%20Clinical%20Exchange%20Channel%20Partner%20API%20v2.4.pdf

module ChangeHealthcare
  class Servlet < ChangeHealthcare::BaseApiObject
    def self.chc_object_name
      'servlets'
    end

    def self.api_order_servlet(params)
      resp = call_api(__method__.to_s.camelize(:lower), params)
      data_nodes = resp.xml.root.children.map { |node| Hash.from_xml(node.to_s)['OBJECT'] }
      data_nodes.each_with_object({}) do |node, hsh|
        hsh[node['name']] ||= []
        hsh[node['name']] << node
      end
    end

    class << self
      private

      def call_api(name, params = {})
        formatted_params = base_api_params.merge(params)
        response = RestClient.get(url(name, formatted_params), cookies: login.cookies)
        ChangeHealthcare::XmlResponse.new(response)
      end

      def base_api_params
        {
          apiuserid: configuration.user_id,
          actionCommand: 'xml'
        }
      end

      def login
        params = {
          userid: configuration.user_id,
          PW: configuration.password,
          hdnBusiness: configuration.facility,
          apiLogin: true,
          actionCommand: 'xml'
        }
        RestClient.get("#{configuration.portal_url}?#{params.to_query}")
      end

      def url(name, params)
        "#{configuration.base_api_url}/#{chc_object_name}.#{name}?#{params.to_query}"
      end
    end
  end
end
