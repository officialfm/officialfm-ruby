require 'cgi'

module OfficialFM
  module Tracks
  
    # Search for tracks
    #
    # @param [String] search_param: a search parameter (eg. name of the track)
    # @param [Integer] limit (50) limit per page (optional)
    # @return [Hashie::Mash] Track list
    def tracks(search_param, options={})
      response = connection.get do |req|
        req.url "/search/tracks/#{CGI::escape(search_param)}", simple_params(options)
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
    def track(track_id, options={})
      response = connection.get do |req|
        req.url "/track/#{track_id}", simple_params(options)
      end
      response.body[0]
    end
    
    # Retrieve users that have voted for this track
    #
    # @param [String] track_id: id
    # @param [Integer] limit (50) limit per page
    # @return [Hashie::Mash] User list
    def track_votes(track_id, options={})
      response = connection.get do |req|
        req.url "/track/#{track_id}/votes", simple_params(options)
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
    def charts(charting, options={})
      response = connection.get do |req|
        req.url "/tracks/charts", simple_params(options)
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
    def latest(options={})
      response = connection.get do |req|
        req.url "/tracks/latest", simple_params(options)
      end
      response.body
    end
    
    ####################################################################
    ######################### Advanced API methods #####################
    ####################################################################

    # Update information of a given track
    #
    # @param [String] track_id: id
    # @param [String] artist_name (optional)
    # @param [String] buy_url (optional)
    # @param [String] country_id (optional)
    # @param [String] downloadable (optional)
    # @param [String] derived_by (optional)
    # @param [String] derived_type (optional)
    # @param [String] description (optional)
    # @param [String] isrc (optional)
    # @param [String] label_name (optional)
    # @param [String] label_none (optional)
    # @param [String] license_type (optional)
    # @param [String] lyrics (optional)
    # @param [String] genre_string (optional)
    # @param [String] original_track_id (optional)
    # @param [String] password (optional)
    # @param [String] pr_url (optional)
    # @param [String] private (optional)
    # @param [String] require_valid_email (optional)
    # @param [String] tag_string (optional)
    # @param [String] title (optional)
    # @param [String] url_1_name (optional)
    # @param [String] url_1 (optional)
    # @param [String] url_2_name (optional)
    # @param [String] url_2 (optional)
    # @param [String] web_url (optional)
    # @return [Hashie::Mash] Track
    def update_track! (track_id, data = {})
      check_auth :update_track
    
      response = connection.put do |req|
        req.url "/track/update/#{track_id}", data
        req.body = { :format => @format }
      end
      response
    end
    
    # Upload a picture for a given track
    #
    # @param [String] track_id: id
    # @param [String] path: path to a picture
    # @param [String] mime: the mime-type of the picture (e.g. image/jpeg, image/png, etc.)
    # @return [Hashie::Mash] Success or error message
    def track_picture! (track_id, path, mime)
      check_auth :track_picture
    
      response = connection.post  do |req|
        req.url "/track/picture/#{track_id}"
        req.body = { :file => Faraday::UploadIO.new(path, mime), :format => @format }
      end
      response
    end
    
    # Vote for a track
    #
    # @param [String] track_id: id
    # @return [Hashie::Mash] Success or error message
    def track_vote! (track_id)
      check_auth :track_vote
    
      response = connection.post  do |req|
        req.url "/track/vote/#{track_id}"
        req.body = { :format => @format }
      end
      response
    end

    # Remove vote for a track
    #
    # @param [String] track_id: id
    # @return [Hashie::Mash] Success or error message
    def track_unvote! (track_id)
      check_auth :track_unvote
    
      response = connection.post  do |req|
        req.url "/track/unvote/#{track_id}"
        req.body = { :format => @format }
      end
      response
    end
    
    # Add a track to a playlist
    #
    # @param [String] track_id: id
    # @param [String] playlist_id: id
    # @return [Hashie::Mash] Success or error message
    def add_track_to_playlist! (track_id)
      check_auth :add_track_to_playlist!
    
      response = connection.post  do |req|
        req.url "/track/#{track_id}/addto/#{playlist_id}"
        req.body = { :format => @format }
      end
      response
    end

    # Remove a track from a playlist
    #
    # @param [String] track_id: id
    # @param [String] playlist_id: id
    # @return [Hashie::Mash] Success or error message
    def remove_track_from_playlist! (track_id)
      check_auth :remove_track_from_playlist!
    
      response = connection.delete  do |req|
        req.url "/track/#{track_id}/removefrom/#{playlist_id}"
        req.body = { :format => @format }
      end
      response
    end
    
    # Upload a new track to Official.fm
    #
    # @param [String] path: path to an mp3, 44.1Khz file
    # @param [String] mime: the mime-type of the file (e.g. audio/mpeg, etc.)
    # @return [Hashie::Mash] Track
    def upload! (track_id, path, mime)
      check_auth :upload
    
      response = connection.post  do |req|
        req.url "/track/upload/#{track_id}"
        req.body = { :file => Faraday::UploadIO.new(path, mime), :format => @format }
      end
      response
    end

  end
end
