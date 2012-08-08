module Marketo
  class Client
    include Savon::Model

    actions :describe_m_object, :get_campaigns_for_source, :get_lead, :get_lead_activity, :get_lead_changes, :get_multiple_leads, :list_m_objects, :list_operation, :request_campaign, :sync_lead, :sync_multiple_leads

    attr_accessor :client
    attr_accessor :header
    attr_accessor :cookie

    def self.new_marketo_client(access_key, secret_key, api_subdomain, api_version )
      @client = Savon::Client.new do
        http.headers["Pragma"] = "no-cache"
        wsdl.endpoint = "https://#{api_subdomain}.marketo.com/soap/mktows/#{api_version}"
        wsdl.document = "http://app.marketo.com/soap/mktows/1_4?WSDL"
      end

      @header = AuthenticationHeader.new(access_key, secret_key)

      Interface.new(@client, @header)
    end
  end
end