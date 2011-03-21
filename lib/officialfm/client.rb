require 'forwardable'

# Note: this gem only supports the Simple API, since the Advanced API
# is still in development

module OfficialFM
  class Client
    extend Forwardable

    include Users
    include Tracks
    include Playlists
    
    attr_reader :api_key

    def_delegators :web_server

    def initialize(options={})
      @api_key = options[:api_key] || OfficialFM.api_key
      # Note: Although the default of the API is to return XML, I think
      # json is more appropriate in the Ruby world
      
      # Note: I really don't understand how js_callback_function works,
      # so I'm not exposing it here. (Is it for AJAX client-side requests?)
      @format = options[:format] || :json
      connection.basic_auth(@api_key)
    end

    # Raw HTTP connection, either Faraday::Connection
    #
    # @return [Faraday::Connection]
    def connection
      params = {}
      params[:access_token] = @access_token if @access_token
      @connection ||= Faraday::Connection.new(:url => api_url, :params => params, :headers => default_headers) do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::Mashify
      end

    end

    # Provides the URL for accessing the API
    #
    # @return [String]
    def api_url
      "http://api.official.fm"
    end
end
