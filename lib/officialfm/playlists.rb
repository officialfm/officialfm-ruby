module OfficialFM
  module Playlists
  
    # Retrieve information about a specific playlist
    #
    # @param [String] track_id: id
    # @param [Bool] api_embed_codes (false) should embed codes be included in the response
    # @return [Hashie::Mash] Playlist
    def show(playlist_id, api_embed_codes=nil)
      response = connection.get do |req|
        req.url "/playlist/#{playlist_id}", :key => @api_key,
          :api_embed_codes => api_embed_codes
      end
      response.body.playlists[0]
    end
  
  end
end
