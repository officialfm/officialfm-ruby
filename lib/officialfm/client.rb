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
      connection
    end

    # Raw HTTP connection, either Faraday::Connection
    #
    # @return [Faraday::Connection]
    def connection
      params = {:key => @api_key, :format => @format}
      @connection ||= Faraday::Connection.new(:url => api_url, :params => params, :headers => default_headers) do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::Mashify
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
  end
end
