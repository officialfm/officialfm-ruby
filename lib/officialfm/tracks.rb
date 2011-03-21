module OfficialFM
  module Tracks
  
    # Retrieve information about a specific track
    #
    # Note: http://official.fm/developers/simple_api#track_show
    # says that api_max_responses is a valid parameter. Why escapes me.
    #
    # @param [String] track_id: id
    # @param [Bool] api_embed_codes (false) should embed codes be included in the response
    # @return [Hashie::Mash] Track list (with only one track)
    def show(user_id, api_embed_codes=nil)
      response = connection.get do |req|
        req.url "/track/#{track_id}", :key => @api_key,
          :api_embed_codes => api_embed_codes
      end
      response.body.tracks[0]
    end
    
    # Retrieve users that have voted for this track
    #
    # @param [String] track_id: id
    # @param [Integer] api_max_responses (50) limit per page
    # @return [Hashie::Mash] User list
    def votes(user_id, api_max_responses=50)
      response = connection.get do |req|
        req.url "/track/#{track_id}/votes", :key => @api_key,
          :api_embed_codes => api_embed_codes
      end
      response.body.tracks[0]
    end
    
    # Retrieve 200 tracks of selected chart
    #
    # @param [String] charting: :today, :week, :month, :year or :all_time
    # @param [String] genre: Genre string (Electronic, Rock, Jazz, ...) (optional)
    # @param [String] country: ISO country id (CH, FR, UK) (optional)
    # @param [Bool] api_embed_codes (false) should embed codes be included in the response (optional)
    # @param [Integer] api_max_responses (200) limit per page (optional)
    # @return [Hashie::Mash] Track list
    def charts(user_id, charting, genre=nil, country=nil, api_embed_codes=false, api_max_responses=200)
      response = connection.get do |req|
        req.url "/tracks/#{track_id}/charts", :key => @api_key,
          :charting => charting, :genre => genre, :country => country,
          :api_embed_codes => api_embed_codes, :api_max_responses => api_max_responses
      end
      response.body.tracks[0]
    end
    
    # Retrieve 200 latest tracks
    #
    # @param [String] genre: Genre string (Electronic, Rock, Jazz, ...) (optional)
    # @param [String] country: ISO country id (CH, FR, UK) (optional)
    # @param [Bool] api_embed_codes (false) should embed codes be included in the response (optional)
    # @param [Integer] api_max_responses (200) limit per page (optional)
    # @return [Hashie::Mash] Track list
    def latest(user_id, charting, genre=nil, country=nil, api_embed_codes=false, api_max_responses=200)
      response = connection.get do |req|
        req.url "/tracks/#{track_id}/latest", :key => @api_key,
          :genre => genre, :country => country,
          :api_embed_codes => api_embed_codes, :api_max_responses => api_max_responses
      end
      response.body.tracks[0]
    end
  
  end
end
