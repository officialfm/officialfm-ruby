# Changelog

## 0.1.1 Aug 03, 2011
  * Missing parameter in add_track_to_playlist and remove_track_from_playlist - fixed

## 0.1.0 Aug 03, 2011
  * Advanced API is now fully supported, see docs here: http://official.fm/developers/advanced
  * OAuth sign-in demo can be found here: https://github.com/officialfm/sign-in-with-officialfm-ruby

## 0.0.4 May 20, 2011
  * Removed 'tracks' workaround, as the official API now includes it by default

## 0.0.3 May 18, 2011
  * Added support for voted_playlists and voted_tracks requests

## 0.0.2 April 21, 2011
  * s/Unofficial/Official, this gem is now endorsed by official.fm
  * Playlist IDs no longer escaped
  * Removed dependency on OAuth2, as it's not needed for the Simple API
  * Better README

## 0.0.1 March 23, 2011
  * Initial version
  * Supports tracks, users, playlists
  * Improved playlist support: tracks, running_time
