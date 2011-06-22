require 'forwardable'

# Note: this gem only supports the Simple API, since the Advanced API
# is still in development

module OfficialFM
  class Client
    extend Forwardable

    include Users
    include Tracks
    include Playlists
    
    attr_reader :api_key, :api_secret

    def_delegators :web_server

    def initialize(options={})
      @api_key = options[:api_key] || OfficialFM.api_key
      @api_secret = options[:api_secret] || OfficialFM.api_secret
      @access_token = options[:access_token]
      # Note: Although the default of the API is to return XML, I think
      # json is more appropriate in the Ruby world
      
      @format = options[:format] || :json
      connection unless @access_token
      connection.token_auth(@access_token) if @access_token
    end
    
    # Check for missing access token
    #
    # @return [Boolean] whether or not to redirect to get an access token
    def needs_access?
      @api_secret and @access_token.to_s == ''
    end

    # Raw HTTP connection, either Faraday::Connection
    #
    # @return [Faraday::Connection]
    def connection
      params = {:key => @api_key, :format => @format}
      @connection ||= Faraday::Connection.new(:url => api_url, :params => params, :headers => default_headers) do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
      end

    end
    
    # @private
    def default_headers
      headers = {
        :accept =>  'application/json',
        :user_agent => 'officialfm Ruby gem'
      }
    end

    # Provides the URL for accessing the API
    #
    # @return [String]
    def api_url
      "http://api.official.fm"
    end
    
    # Provides raw access to the OAuth2 Client
    #
    # @return [OAuth2::Client]
    def oauth_client
      if @oauth_client
        @oauth_client
      else
        conn ||= Faraday::Connection.new \
          :url => "https://api.gowalla.com",
          :headers => default_headers

        oauth= OAuth2::Client.new(api_key, api_secret, oauth_options = {
          :site => 'https://api.gowalla.com',
          :authorize_url => 'https://gowalla.com/api/oauth/new',
          :access_token_url => 'https://gowalla.com/api/oauth/token'
        })
        oauth.connection = conn
        oauth
      end
    end
  end
end
