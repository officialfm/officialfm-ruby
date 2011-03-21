module OfficialFM
  module Tracks
  
    # Search for tracks
    #
    # @param [String] search_param: a search parameter (eg. name of the track)
    # @param [Integer] limit (50) limit per page (optional)
    # @return [Hashie::Mash] Track list
    def tracks(search_param, limit=nil)
      response = connection.get do |req|
        req.url "/search/tracks/#{search_param}", :api_max_responses => limit
      end
      response.body
    end
  
    # Retrieve information about a specific track
    #
    # Note: http://official.fm/developers/simple_api#track_show
    # says that api_max_responses is a valid parameter. Why escapes me.
    #
    # @param [String] track_id: id
    # @param [Bool] embed (false) should embed codes be included in the response
    # @return [Hashie::Mash] Track
    def show(track_id, embed=nil)
      response = connection.get do |req|
        req.url "/track/#{track_id}",
          :api_embed_codes => embed
      end
      response.body[0]
    end
    
    # Retrieve users that have voted for this track
    #
    # @param [String] track_id: id
    # @param [Integer] limit (50) limit per page
    # @return [Hashie::Mash] User list
    def votes(track_id, limit=50)
      response = connection.get do |req|
        req.url "/track/#{track_id}/votes", :api_max_responses => limit
      end
      response.body
    end
    
    # Retrieve 200 tracks of selected chart
    #
    # @param [String] charting: :today, :week, :month, :year or :all_time
    # @param [String] genre: Genre string (Electronic, Rock, Jazz, ...) (optional)
    # @param [String] country: ISO country id (CH, FR, UK) (optional)
    # @param [Bool] embed (false) should embed codes be included in the response (optional)
    # @param [Integer] limit (200) limit per page (optional)
    # @return [Hashie::Mash] Track list
    def charts(charting, genre=nil, country=nil, embed=nil, limit=nil)
      response = connection.get do |req|
        req.url "/tracks/charts",
          :charting => charting, :genre => genre, :country => country,
          :api_embed_codes => embed, :api_max_responses => api_max_responses
      end
      response.body
    end
    
    # Retrieve 200 latest tracks
    #
    # @param [String] genre: Genre string (Electronic, Rock, Jazz, ...) (optional)
    # @param [String] country: ISO country id (CH, FR, UK) (optional)
    # @param [Bool] embed (false) should embed codes be included in the response (optional)
    # @param [Integer] limit (200) limit per page (optional)
    # @return [Hashie::Mash] Track list
    def latest(genre=nil, country=nil, api_embed_codes=false, limit=nil)
      response = connection.get do |req|
        req.url "/tracks/latest", :genre => genre, :country => country,
        :api_embed_codes => embed, :api_max_responses => limit
      end
      response.body
    end
  
  end
end
