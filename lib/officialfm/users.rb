module OfficialFM
  module Users

    # Retrieve information about a specific user
    #
    # @param [String] user_id: id or login
    # @return [Hashie::Mash] User
    def show(user_id)
      response = connection.get do |req|
        req.url "/user/#{user_id}/tracks", :key => @api_key
      end
      response.body.users[0]
    end

    # Retrieve a list of the tracks of this user
    #
    # @param [String] user_id: id or login
    # @param [Bool] api_embed_codes (false) should embed codes be included in the response
    # @param [Integer] api_max_responses (50) limit per page
    # @return [Hashie::Mash] Track list
    def tracks(user_id, api_embed_codes=nil, api_max_responses=50)
      response = connection.get do |req|
        req.url "/user/#{user_id}/tracks", :key => @api_key,
          :api_embed_codes => api_embed_codes, :api_max_responses => api_max_responses
      end
      response.body.tracks
    end
    
    # Retrieve a list of the playlists of this user
    #
    # @param [String] user_id: id or login
    # @param [Bool] api_embed_codes (false) should embed codes be included in the response
    # @param [Integer] api_max_responses (50) limit per page
    # @return [Hashie::Mash] Playlist list
    def playlists(user_id, api_embed_codes=nil, api_max_responses=50)
      response = connection.get do |req|
        req.url "/user/#{user_id}/playlists", :key => @api_key,
          :api_embed_codes => api_embed_codes, :api_max_responses => api_max_responses
      end
      response.body.playlists
    end
    
    # Retrieve a list of the contacts of this user
    #
    # @param [String] user_id: id or login
    # @param [Integer] api_max_responses (50) limit per page
    # @return [Hashie::Mash] User list
    def contacts(user_id, api_max_responses=50)
      response = connection.get do |req|
        req.url "/user/#{user_id}/contacts", :key => @api_key,
          :api_max_responses => api_max_responses
      end
      response.body.users
    end
    
    # Retrieve a list of the subscribers of this user
    #
    # @param [String] user_id: id or login
    # @param [Integer] api_max_responses (50) limit per page
    # @return [Hashie::Mash] User list
    def subscribers(user_id, api_max_responses=50)
      response = connection.get do |req|
        req.url "/user/#{user_id}/subscribers", :key => @api_key,
          :api_max_responses => api_max_responses
      end
      response.body.users
    end
    
    # Retrieve a list of the subscriptions of this user
    #
    # @param [String] user_id: id or login
    # @param [Integer] api_max_responses (50) limit per page
    # @return [Hashie::Mash] User list
    def subscriptions(user_id, api_max_responses=50)
      response = connection.get do |req|
        req.url "/user/#{user_id}/subscriptions", :key => @api_key,
          :api_max_responses => api_max_responses
      end
      response.body.users
    end

  end
end
