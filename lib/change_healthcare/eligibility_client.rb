class ChangeHealthcare::EligibilityClient

	def self.authenticate(url, client_id, client_secret)
    response = RestClient::Request.execute(
      method: :post,
      url: url,
      payload: {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: "client_credentials",
      }.to_json,
      headers: {
        "Content-Type" => "application/json"
      },
      timeout: 15,
      content_type: :json
    )
    body = JSON.parse(response.body)
    @token = body["access_token"]
    delta = body["expires_in"]
    @expires_at = Time.now + delta.seconds
    return @token, @expires_at
  end

  def self.x12_270(subscriber)
    [
      "ISA*00*          *01*password  *ZZ*#{submitter_id}*ZZ*#{interchange_receiver_id}*200708*0603*^*00501*#{control_number}*0*P*:~",
      "GS*HS*#{gs_user_id}*#{trading_partner_service_id}*#{transmission_datetime.strftime("%Y%m%d")}*#{transmission_datetime.strftime("%H%M")}*#{control_number}*X*005010X279A1~",
      "ST*270*#{control_number}*005010X279A1~",
      "BHT*0022*13*#{control_number}*#{transmission_datetime.strftime("%Y%m%d")}*#{transmission_datetime.strftime("%H%M")}~",
      "HL*1**20*1~",
      "NM1*PR*2*Unknown*****PI*#{trading_partner_service_id}~",
      "HL*2*1*21*1~",
      "NM1*1P*2*MDLIVE MEDICAL GROUP, PA*****XX*#{npi}~",
      "PRV*AD*PXC*54321g~",
      "HL*3*2*22*1~",
      "TRN*1*#{control_number}*9EMDEON999~",
      "NM1*IL*1*#{subscriber_params.dig(:lastName)}*#{subscriber_params.dig(:firstName)}****MI*#{subscriber_params.dig(:memberId)}~",
      "DMG*D8*#{subscriber_params.dig(:dateOfBirth)}*#{subscriber_params.dig(:gender).first}~",
      *dependent_segments,
      "DTP*291*D8*#{date_of_service}~",
      "EQ*#{service_type_code}~",
      place_of_service_indicator,
      "SE*#{number_of_segments}*#{control_number}~",
      "GE*1*#{control_number}~",
      "IEA*1*#{control_number}~",
    ].join("")
  end

  private
 
  def subscriber_params(subscriber)
    if subscriber_is_dependent?
      {
        memberId: (subscriber.parent_customer_insurance_detail.member_id || "").gsub(/[^0-9a-z\\s]/i, ""),
        firstName: subscriber.parent_customer_insurance_detail.first_name,
        lastName: subscriber.parent_customer_insurance_detail.last_name,
        dateOfBirth: subscriber.parent_customer_insurance_detail.dob.strftime("%Y%m%d"),
        gender: subscriber.parent_customer_insurance_detail.gender.upcase
      }
    else
      {
        memberId: member_id.gsub(/[^0-9a-z\\s]/i, ""),
        firstName: subscriber.first_name,
        lastName: subscriber.last_name,
        dateOfBirth: subscriber.birthdate.strftime("%Y%m%d"),
        gender: subscriber.gender.upcase
      }
    end
  end

  def dependent_params(subscriber)
    dependent_params = {
      firstName: subscriber.first_name,
      lastName: subscriber.last_name,
      dateOfBirth: subscriber.birthdate.strftime("%Y%m%d"),
      gender: subscriber.gender.upcase
    }
    dependent_params["memberId"] = member_id.gsub(/[^0-9a-z\\s]/i, "") if dependent_subscriber?

    dependent_params
  end

end