# https://cli-cert.emdeon.com/api/cert/order.html
class ChangeHealthcare::OrderableDoc < ChangeHealthcare::BaseApiObject
  def self.attributes
    [:orderable, :document, :orderable_description, :orderabledoc, :order_code]
  end

  attr_accessor(*self.attributes)

  def self.chc_object_name
    "orderabledoc"
  end

  def self.search_docs_for_order(params={})
    resp = call_api(__method__.to_s, params, false)
    response_to_list(resp)
  end
end
