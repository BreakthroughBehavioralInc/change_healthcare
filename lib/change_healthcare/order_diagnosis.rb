module ChangeHealthcare
  class OrderDiagnosis < ChangeHealthcare::BaseApiObject
    def self.attributes
      %i[
        name
        op
        date
        clientid
        split_code
        orderable
        description
        exclusive_flag
        cpp_count
        expiration_date
        orderdiagnosis
        orderable_type
        special_test_flag
        ordertest
        specimen
        clearance
        freq_abn
        icd_10_cm_code
        order_diag_description
        has_aoe
        order
        icd_9_cm_code
        placer_order_number
        orderable_description
        ownerid
        created_by
        lcp_fda_flag
        order_code
        sequence
        estimated_cost
        category
        user_description
      ]
    end

    attr_accessor(*attributes)

    def self.chc_object_name
      'orderdiagnosis'
    end

    # https://cli-cert.emdeon.com/api/cert/orderdiagnosis.html#get
    # params = {orderdiagnosis: xxxxxxxxxx} or {order: xxxxxxxxxx}
    def self.get(params)
      # if orderdiagnosis reference is passed in use default orderdiagnosis.get call
      if params[:orderdiagnosis].present?
        resp = call_api(__method__.to_s, params, false)
        response_to_list(resp)
      # if order reference is passed in use servlet.apiOrderServlet to grab all order details and fetch orderdiagnosis info
      elsif params[:order].present?
        Servlet.api_order_servlet(params)['orderdiagnosis'].map { |diagnosis| new(diagnosis) }
      end
    end
  end
end
