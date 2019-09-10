require 'spec_helper'

RSpec.describe ChangeHealthcare::Order do
  describe ".generate_order_number" do
    it "Retrieves the next requisition number for the lab" do
      resp = ChangeHealthcare::Order.generate_order_number({ lab: "23402537", orderingorganization: "23402521" })

      expect(resp.first).to be_a_kind_of(ChangeHealthcare::Order)
      expect(resp.first.placer_order_number).not_to be_nil
    end
  end

  describe ".search_by_order_info" do
    it "Retrieves the next requisition number for the lab" do
      mdl_config
      resp = ChangeHealthcare::Order.search_by_order_info({ placer_order_number: "76047", orderingorganization: "3004115375" })

      expect(resp.first).to be_a_kind_of(ChangeHealthcare::Order)
      expect(resp.first.first_name).not_to be_nil
    end
  end

  describe ".e_order_summary_link" do
    let(:expected_response) do
      "https://cli-cert.changehealthcare.com/servlet/DxLogin?G_ADR=1478%2BNorth%2BFirst%2BSt&G_CIT=Madison&G_DOB=05%2F17%2F1950&G_FNM=Robert&G_LNM=Wilson&G_MID=G&G_PHN=9132583415&G_PHW=9165555555&G_REL=2&G_SEX=M&G_STA=CA&G_ZIP=95654&I_ADR=PO+Box+8019&I_CTY=Appleton&I_GRP=4567&I_IADR=1478%2BNorth%2BFirst%2BSt+&I_ICIT=Madison&I_IDOB=05%2F17%2F1950&I_IFNM=Robert&I_IID=000001284&I_ILNM=Wilson&I_IMID=G&I_INS=GUARD&I_IPHN=9132583415&I_ISEX=M&I_ISTA=CA&I_IZIP=95654&I_NAM=Guardian&I_REL=SP&I_STA=WI&I_TYP=O&I_ZIP=54912&O_ClientID=08153694&O_ExpectedDate=08%2F15%2F2019&O_ICD10=Z00.00&O_Lab=LabCorp+Tampa&O_LabInstr=Lab%2BInstructions&O_Number=76047&O_Oper=mdlive&O_Phyid=13507&O_Rep=Order%2BComments&O_Type=I&PW=practice00&P_ACT=123456&P_ADR=1478%2BNorth%2BFirst%2BSt&P_CIT=Madison&P_DOB=05%2F25%2F1952&P_FNM=Shirley&P_LNM=Wilson&P_MID=A&P_PHN=9132583415&P_SEX=F&P_STA=CA&P_ZIP=95654&actionCommand=EOrderSummary&apilogon=true&hdnBusiness=3004115375&summary=true&target=jsp%2Flab%2Forder%2FESummaryOrder.jsp&userid=p_mdlive1"
    end

    let(:params) do
      {
        "P_ACT" => "123456",
        "P_LNM" => "Wilson",
        "P_FNM" => "Shirley",
        "P_MID" => "A",
        "P_ADR" => "1478+North+First+St",
        "P_CIT" => "Madison",
        "P_STA" => "CA",
        "P_ZIP" => "95654",
        "P_SEX" => "F",
        "P_DOB" => "05/25/1952",
        "P_PHN" => "9132583415",
        "G_LNM" => "Wilson",
        "G_FNM" => "Robert",
        "G_MID" => "G",
        "G_ADR" => "1478+North+First+St",
        "G_SEX" => "M",
        "G_CIT" => "Madison",
        "G_STA" => "CA",
        "G_ZIP" => "95654",
        "G_DOB" => "05/17/1950",
        "G_REL" => "2",
        "G_PHN" => "9132583415",
        "G_PHW" => "9165555555",
        "I_INS" => "GUARD",
        "I_NAM" => "Guardian",
        "I_ADR" => "PO Box 8019",
        "I_CTY" => "Appleton",
        "I_STA" => "WI",
        "I_ZIP" => "54912",
        "I_TYP" => "O",
        "I_IID" => "000001284",
        "I_GRP" => "4567",
        "I_REL" => "SP",
        "I_ILNM"  => "Wilson",
        "I_IFNM"  => "Robert",
        "I_IMID"  => "G",
        "I_IADR"  => "1478+North+First+St ",
        "I_ICIT"  => "Madison",
        "I_ISTA"  => "CA",
        "I_IZIP"  => "95654",
        "I_ISEX"  => "M",
        "I_IDOB"  => "05/17/1950",
        "I_IPHN"  => "9132583415",
        "O_ClientID" => "08153694",
        "O_Lab" => "LabCorp Tampa",
        "O_Type" => "I",
        "O_Phyid" => "13507",
        "O_Oper" => "mdlive",
        "O_ICD10" => "Z00.00",
        "O_ExpectedDate" => "08/15/2019",
        "O_LabInstr" => "Lab+Instructions",
        "O_Rep"  => "Order+Comments",
        "O_Number" => "76047"
      }
    end

    it "Returns the order_summary_screen" do
      mdl_config
      resp = ChangeHealthcare::Order.e_order_summary_link(params)

      expect(resp).to eq(expected_response)
    end
  end


  describe ".e_order_html_link" do
    let(:expected_response) do
      "https://cli-cert.changehealthcare.com/servlet/DxLogin?PW=practice00&actionCommand=print&apiLogin=true&apiuserid=p_mdlive1&hdnBusiness=3004115375&orderid=3004834601&target=servlet%2Fservlets.apiOrderServlet%3F&userid=p_mdlive1"
    end

    let(:params) { {orderid: "3004834601"} }

    it "Returns the order_summary_screen" do
      mdl_config
      resp = ChangeHealthcare::Order.e_order_html_link(params)

      expect(resp).to eq(expected_response)
    end
  end
end
