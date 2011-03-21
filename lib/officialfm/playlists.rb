module OfficialFM
  module Playlists
  
    # Search for playlists
    #
    # @param [String] search_param: a search parameter (eg. name of the playlist)
    # @return [Hashie::Mash] Playlist list
    def search(search_param)
      response = connection.get do |req|
        req.url "/search/playlists/#{search_param}"
      end
      response.body.playlists
    end
  
    # Retrieve information about a specific playlist
    #
    # @param [String] track_id: id
    # @param [Bool] api_embed_codes (false) should embed codes be included in the response
    # @return [Hashie::Mash] Playlist
    def show(playlist_id, api_embed_codes=nil)
      response = connection.get do |req|
        req.url "/playlist/#{playlist_id}",
          :api_embed_codes => api_embed_codes
      end
      response.body.playlists[0]
    end
    
    # Retrieve users that have voted for this playlist
    #
    # @param [String] track_id: id
    # @param [Integer] api_max_responses (50) limit per page
    # @return [Hashie::Mash] User list
    def votes(playlist_id, api_max_responses=50)
      response = connection.get do |req|
        req.url "/playlist/#{playlist_id}/votes",
          :api_embed_codes => api_embed_codes
      end
      response.body.users
    end
  
  end
end
