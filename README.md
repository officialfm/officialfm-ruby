# official.fm

Unofficial Ruby wrapper for the [official.fm Simple API](http://official.fm/developers).

## Installation

    sudo gem install officialfm

## Get your API key

Be sure and get your API key: [http://official.fm/developers/manage](http://official.fm/developers/manage)

## Usage

### Instantiate a client

    officialfm = OfficialFM::Client.new(:api_key => 'your_api_key')

#### Examples

    officialfm.user('chab')
    puts user.name

    officialfm.tracks('Dare', {:limit => 10, :embed => false}).each |track| do
      puts "#{track.name} by #{track.artist_string}"
    end
    
For a complete example of web-app using Sinatra in conjunction with
this gem, see [ofmtweet](https://github.com/nddrylliog/ofmtweet).

## Additions to the original API

### playlist.tracks

For the time being, the structure of playlists in the JSON response of the official.fm
server is:

		{   
				"tracks_count":4,
				"tracks_list":"57854,40057,11290,12818",
		}

It'd be more convenient to have something like:

		{   
				"tracks": [ 57854, 40057, 11290, 12818 ],
		}

But until it's fixed, this gem emulates it, so you can still write pretty code like:

    officialfm.playlists('R&B', :limit => 1)[0].tracks.do |track|
			puts "  * #{officialfm.track(track).title}"
		end

### playlist.running\_time

The original API has a `length` attribute in playlists, but unfortunately
we can't use it from the Ruby side with Hashie, because it's already the number
of fields of the hash (as I understand it).

It can still be accessed with `playlist["length"]` but since it's not pretty,
the gem allows you to access it like this:

		puts "#{playlist.running_time}s of pure bliss"

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Amos Wenger. See LICENSE for details.

Based on [@pengwynn's Gowalla API wrapper](https://github.com/pengwynn/gowalla)

A huge load of thanks to pengwynn for releasing it open-source! It was wonderful
to work from his extra-clean codebase.
