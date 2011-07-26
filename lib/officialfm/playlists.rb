require 'cgi'

module OfficialFM
  module Playlists
  
    # Search for playlists
    #
    # @param [String] search_param: a search parameter (eg. name of the playlist)
    # @param [Integer] limit (50) limit per page (optional)
    # @return [Hashie::Mash] Playlist list
    def playlists(search_param, options={})
      response = connection.get do |req|
        req.url "/search/playlists/#{CGI::escape(search_param)}", simple_params(options)
      end
      
      response.body.map do |pl| improve(pl) end
    end
  
    # Retrieve information about a specific playlist
    #
    # @param [String] track_id: id
    # @param [Bool] embed (false) should embed codes be included in the response
    # @return [Hashie::Mash] Playlist
    def playlist(playlist_id, options={})
      response = connection.get do |req|
        req.url "/playlist/#{playlist_id}", simple_params(options)
      end
      improve(response.body[0])
    end
    
    # Retrieve users that have voted for this playlist
    #
    # @param [String] playlist_id: id
    # @param [Integer] limit (50) limit per page
    # @return [Hashie::Mash] User list
    def playlist_votes(playlist_id, options={})
      response = connection.get do |req|
        req.url "/playlist/#{playlist_id}/votes", simple_params(options)
      end
      response.body
    end
    
    def improve(playlist)
      # the length field is already used. Note: running_time is in seconds
      playlist.running_time = playlist["length"]
      playlist
    end
       
    ####################################################################
    ######################### Advanced API methods #####################
    ####################################################################

    # Update information of a given playlist
    #
    # @param [String] playlist_id: id
    # @param [String] description (optional)
    # @param [String] name (optional)
    # @param [String] password (optional)
    # @param [String] private (optional)
    # @return [Hashie::Mash] Playlist
    def update_playlist! (playlist_id, data = {})
      check_auth :update_playlist
    
      response = connection.put do |req|
        req.url "/playlist/update/#{playlist_id}", data
        req.body = { :format => @format }
      end
      response
    end
    
    # Upload a picture for a given playlist
    #
    # @param [String] playlist_id: id
    # @param [String] path: path to a picture
    # @param [String] mime: the mime-type of the picture (e.g. image/jpeg, image/png, etc.)
    # @return [Hashie::Mash] Success or error message
    def playlist_picture! (playlist_id, path, mime)
      check_auth :playlist_picture
    
      response = connection.post  do |req|
        req.url "/playlist/picture/#{playlist_id}"
        req.body = { :file => Faraday::UploadIO.new(path, mime), :format => @format }
      end
      response
    end
    
    # Remove a playlist
    #
    # @param [String] playlist_id: id
    # @return [Hashie::Mash] Success or error message
    def playlist_remove! (playlist_id)
      check_auth :playlist_remove
    
      response = connection.delete  do |req|
        req.url "/playlist/remove/#{playlist_id}"
        req.body = { :format => @format }
      end
      response
    end
    
    # Create a playlist
    #
    # @param [String] name: playlist name
    # @param [String] track_id: first track id of the new playlist
    # @return [Hashie::Mash] Playlist object
    def playlist_create! (name, track_id)
      check_auth :playlist_create
    
      response = connection.post  do |req|
        req.url "/playlist/create"
        req.body = { :format => @format, :name => name, :track_id => track_id }
      end
      response
    end
    
    # Vote for a playlist
    #
    # @param [String] playlist_id: id
    # @return [Hashie::Mash] Success or error message
    def playlist_vote! (playlist_id)
      check_auth :playlist_vote
    
      response = connection.post  do |req|
        req.url "/playlist/vote/#{playlist_id}"
        req.body = { :format => @format }
      end
      response
    end
    
    # Remote vote for a playlist
    #
    # @param [String] playlist_id: id
    # @return [Hashie::Mash] Success or error message
    def playlist_unvote! (playlist_id)
      check_auth :playlist_unvote
    
      response = connection.post  do |req|
        req.url "/playlist/unvote/#{playlist_id}"
        req.body = { :format => @format }
      end
      response
    end
    
  end
end
