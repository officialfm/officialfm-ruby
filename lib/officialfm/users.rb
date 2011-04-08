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
    
    def users(search_term)

    # Retrieve a list of the tracks of this user
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
    
    # Retrieve a list of the playlists of this user
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
    
    # Retrieve a list of the contacts of this user
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
    
    # Retrieve a list of the subscribers of this user
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
    
    # Retrieve a list of the subscriptions of this user
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

  end
end
