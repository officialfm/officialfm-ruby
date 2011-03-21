module OfficialFM
  module Playlists
  
    # Search for playlists
    #
    # @param [String] search_param: a search parameter (eg. name of the playlist)
    # @param [Integer] limit (50) limit per page (optional)
    # @return [Hashie::Mash] Playlist list
    def playlists(search_param)
      response = connection.get do |req|
        req.url "/search/playlists/#{search_param}", :api_max_responses => limit
      end
      response.body
    end
  
    # Retrieve information about a specific playlist
    #
    # @param [String] track_id: id
    # @param [Bool] embed (false) should embed codes be included in the response
    # @return [Hashie::Mash] Playlist
    def playlist(playlist_id, embed=nil)
      response = connection.get do |req|
        req.url "/playlist/#{playlist_id}",
          :api_embed_codes => embed
      end
      response.body[0]
    end
    
    # Retrieve users that have voted for this playlist
    #
    # @param [String] track_id: id
    # @param [Integer] api_max_responses (50) limit per page
    # @return [Hashie::Mash] User list
    def playlist_votes(playlist_id, limit=nil)
      response = connection.get do |req|
        req.url "/playlist/#{playlist_id}/votes",
          :api_embed_codes => embed
      end
      response.body
    end
  
  end
end
