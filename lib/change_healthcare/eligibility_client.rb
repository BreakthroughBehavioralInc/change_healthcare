class ChangeHealthcare::EligibilityClient
  include Singleton

  TOKEN_EXPIRATION_BUFFER = 2.minutes

  attr_reader :token, :expires_at
  
  def authenticate(auth_url, client_id, client_secret)
    response = RestClient::Request.execute(
      method: :post,
      url: auth_url,
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
    delta = body["expires_in"]
    @expires_at = Time.now + delta.seconds
    @token = body["access_token"]
  end

  def auth_token(auth_url, client_id, client_secret)
    @token = authenticate(auth_url, client_id, client_secret) if token_is_about_to_expire?
    token
  end

  def fetch_271(payload, url, timeout)
    RestClient::Request.execute(
      method: :post,
      url: url,
      payload: payload.to_json,
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@token}"
      },
      timeout: timeout.to_i || 30,
      content_type: :json
    )
  end

  def x12_270(opt = {})
    [
      "ISA*00*          *01*password  *ZZ*#{opt[:submitter_id]}*ZZ*#{opt[:interchange_receiver_id]}*200708*0603*^*00501*#{opt[:control_number]}*0*P*:~",
      "GS*HS*#{opt[:gs_user_id]}*#{opt[:trading_partner_service_id]}*#{opt[:transmission_datetime].strftime("%Y%m%d")}*#{opt[:transmission_datetime].strftime("%H%M")}*#{opt[:control_number]}*X*005010X279A1~",
      "ST*270*#{opt[:control_number]}*005010X279A1~",
      "BHT*0022*13*#{opt[:control_number]}*#{opt[:transmission_datetime].strftime("%Y%m%d")}*#{opt[:transmission_datetime].strftime("%H%M")}~",
      "HL*1**20*1~",
      "NM1*PR*2*Unknown*****PI*#{opt[:trading_partner_service_id]}~",
      "HL*2*1*21*1~",
      "NM1*1P*2*MDLIVE MEDICAL GROUP, PA*****XX*#{opt[:npi]}~",
      "PRV*AD*PXC*193200000X~",
      "HL*3*2*22*1~",
      "TRN*1*#{opt[:control_number]}*9EMDEON999~",
      "NM1*IL*1*#{opt[:subscriber_params].dig(:lastName)}*#{opt[:subscriber_params].dig(:firstName)}****MI*#{opt[:subscriber_params].dig(:memberId)}~",
      "DMG*D8*#{opt[:subscriber_params].dig(:dateOfBirth)}*#{opt[:subscriber_params].dig(:gender).first}~",
      *opt[:dependent_segments],
      "DTP*291*D8*#{opt[:date_of_service]}~",
      "EQ*#{opt[:service_type_code]}~",
      opt[:place_of_service_indicator],
      "SE*#{opt[:number_of_segments]}*#{opt[:control_number]}~",
      "GE*1*#{opt[:control_number]}~",
      "IEA*1*#{opt[:control_number]}~",
    ].join("")
  end 

  private

  def token_is_about_to_expire?
    token.blank? || (Time.now + TOKEN_EXPIRATION_BUFFER) > expires_at
  end

end