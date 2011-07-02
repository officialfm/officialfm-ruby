require 'forwardable'
require 'faraday/request/officialfm_oauth'
require 'officialfm/authentication'

module OfficialFM
  class Client
    extend Forwardable

    include Users
    include Tracks
    include Playlists
    include Authentication
    
    attr_reader :api_key, :api_secret

    def_delegators :web_server, :authorize_url, :access_token_url

    def initialize(options={})
      @api_key = options[:api_key] || OfficialFM.api_key
      @api_secret = options[:api_secret] || OfficialFM.api_secret
      @access_token = options[:access_token]
      @access_secret = options[:access_secret]
      # Note: Although the default of the API is to return XML, I think
      # json is more appropriate in the Ruby world
      
      @format = options[:format] || :json
      connection unless @access_token
    end

    # Raw HTTP connection, either Faraday::Connection
    #
    # @return [Faraday::Connection]
    def connection
      options = {
        :url => api_url,
        :params => {
          :key => @api_key,
          :format => @format
        },
        :headers => default_headers
      }
    
      @connection ||= Faraday.new(options) do |builder|
        builder.use Faraday::Request::OfficialFMOAuth, authentication if authenticated?
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
        builder.adapter Faraday.default_adapter
      end

    end
    
    # @private
    def default_headers
      headers = {
        :accept =>  'application/json',
        :user_agent => "officialfm ruby gem version #{OfficialFM::VERSION}"
      }
    end

    # Provides the URL for accessing the API
    #
    # @return [String]
    def api_url
      "http://api.official.fm"
    end
  end
end
