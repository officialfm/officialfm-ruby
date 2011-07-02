require 'cgi'

module OfficialFM
  module Users

    # Search for users
    #
    # @param [String] search_param: a search parameter (eg. name of the user)
    # @param [Integer] limit (50) limit per page
    # @return [Hashie::Mash] User list
    def users(search_param, options={})
      response = connection.get do |req|
        req.url "/search/users/#{CGI::escape(search_param)}", :api_max_responses => options[:limit]
      end
      response.body
    end

    # Retrieve information about a specific user
    #
    # @param [String] user_id: id or login
    # @return [Hashie::Mash] User
    def user(user_id)
      response = connection.get do |req|
        req.url "/user/#{user_id}"
      end
      response.body[0]
    end

    # Retrieve a list of the tracks of a given user
    #
    # @param [String] user_id: id or login
    # @param [Integer] limit (50) limit per page
    # @param [Bool] embed (false) should embed codes be included in the response
    # @return [Hashie::Mash] Track list
    def user_tracks(user_id, options={})
      response = connection.get do |req|
        req.url "/user/#{user_id}/tracks",
          :api_embed_codes => options[:embed], :api_max_responses => options[:limit]
      end
      response.body
    end
    
    # Retrieve a list of the tracks a given user has voted for
    #
    # @param [String] user_id: id or login
    # @param [Integer] limit (50) limit per page
    # @param [Bool] embed (false) should embed codes be included in the response
    # @return [Hashie::Mash] Track list
    def voted_tracks(user_id, options={})
      response = connection.get do |req|
        req.url "/user/#{user_id}/voted_tracks",
          :api_embed_codes => options[:embed], :api_max_responses => options[:limit]
      end
      response.body
    end
    
    # Retrieve a list of the playlists of a given user
    #
    # @param [String] user_id: id or login
    # @param [Integer] limit (50) limit per page
    # @param [Bool] embed (false) should embed codes be included in the response
    # @return [Hashie::Mash] Playlist list
    def user_playlists(user_id, options={})
      response = connection.get do |req|
        req.url "/user/#{user_id}/playlists",
          :api_embed_codes => options[:embed], :api_max_responses => options[:limit]
      end
      response.body
    end
    
    # Retrieve a list of the playlists a given user has voted for
    #
    # @param [String] user_id: id or login
    # @param [Integer] limit (50) limit per page
    # @param [Bool] embed (false) should embed codes be included in the response
    # @return [Hashie::Mash] Playlist list
    def voted_playlists(user_id, options={})
      response = connection.get do |req|
        req.url "/user/#{user_id}/voted_playlists",
          :api_embed_codes => options[:embed], :api_max_responses => options[:limit]
      end
      response.body
    end
    
    # Retrieve a list of the contacts of a given user
    #
    # @param [String] user_id: id or login
    # @param [Integer] limit (50) limit per page
    # @return [Hashie::Mash] User list
    def user_contacts(user_id, options={})
      response = connection.get do |req|
        req.url "/user/#{user_id}/contacts",
          :api_max_responses => options[:limit]
      end
      response.body
    end
    
    # Retrieve a list of the subscribers of a given user
    #
    # @param [String] user_id: id or login
    # @param [Integer] limit (50) limit per page
    # @return [Hashie::Mash] User list
    def user_subscribers(user_id, options={})
      response = connection.get do |req|
        req.url "/user/#{user_id}/subscribers",
          :api_max_responses => options[:limit]
      end
      response.body
    end
    
    # Retrieve a list of the subscriptions of a given user
    #
    # @param [String] user_id: id or login
    # @param [Integer] limit (50) limit per page
    # @return [Hashie::Mash] User list
    def user_subscriptions(user_id, options={})
      response = connection.get do |req|
        req.url "/user/#{user_id}/subscriptions",
          :api_max_responses => options[:limit]
      end
      response.body
    end
    
    ####################################################################
    ######################### Advanced API methods #####################
    ####################################################################

    # Retrieve information about the logged in user
    #
    # @return [Hashie::Mash] User
    def profile
      check_auth :profile
    
      response = connection.post do |req|
        req.url '/user/profile'
      end
      response.body[0]
    end
    
    # Retrieve tracks of the logged in user
    #
    # @return [Hashie::Mash] Track list
    def own_tracks
      check_auth :own_tracks
      
      response = connection.post do |req|
        req.url '/user/tracks'
      end
      response
    end
    
    # Retrieve dropbox tracks of the logged in user
    #
    # @return [Hashie::Mash] Track list
    def dropbox
      check_auth :dropbox
      
      response = connection.post do |req|
        req.url '/user/dropbox'
      end
      response
    end
    
    # Retrieve playlists of the logged in user
    #
    # @return [Hashie::Mash] Playlist list
    def own_playlists
      check_auth :own_playlists
      
      response = connection.post do |req|
        req.url '/user/playlists'
      end
      response
    end
    
    # Retrieve events of the logged in user's newsfeed
    #
    # @return [Hashie::Mash] Event list
    def newsfeed
      check_auth :newsfeed
      
      response = connection.post do |req|
        req.url '/user/newsfeed'
      end
      response
    end
    
    # Update information of the logged in user
    #
    # @param [String] email (optional)
    # @param [String] city (optional)
    # @param [String] country_id (optional)
    # @param [String] url (optional)
    # @param [String] profile (optional)
    # @param [String] birthdate (optional)
    # @param [String] gender (optional)
    # @return [Hashie::Mash] User
    def update! (data = {})
      check_auth :update
    
      response = connection.put do |req|
        req.url '/user/update', data
      end
      response
    end
    
    # Subscribe the logged in user to a given user
    #
    # @param [String] user_id: the user to subscribe to
    # @return [Hashie::Mash] Success or error message
    def subscribe! (user_id)
      check_auth :subscribe
    
      response = connection.post  do |req|
        req.url "/user/subscribe/#{user_id}", data
      end
      response
    end
    
    # Unsubscribe the logged in user from a given user
    #
    # @param [String] user_id: the user to unsubscribe from
    # @return [Hashie::Mash] Success or error message
    def unsubscribe! (user_id)
      check_auth :unsubscribe
    
      response = connection.post  do |req|
        req.url "/user/unsubscribe/#{user_id}", data
      end
      response
    end
    
    # Upload a picture for authenticated user
    #
    # @param [String] path: path to a picture
    # @param [String] mime: the mime-type of the picture (e.g. image/jpeg, image/png, etc.)
    # @return [Hashie::Mash] Success or error message
    def picture! (path, mime)
      check_auth :picture
    
      response = connection.post  do |req|
        req.url "/user/picture/", :file => Faraday::UploadIO.new(path, mime)
      end
      response
    end

  end
end

