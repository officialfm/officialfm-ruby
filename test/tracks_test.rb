require 'helper'

class TracksTest < Test::Unit::TestCase

  context "When using the official.fm API and working with Tracks" do
    setup do
      @client = officialfm_test_client
    end
    
    should "search for 5 tracks with the 'Quelque Chose' search term" do
      stub_get('http://api.official.fm/search/tracks/Quelque+Chose?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=5', 'tracks.json')
      tracks = @client.tracks('Quelque Chose', :limit => 5)
      tracks.length.should == 5
      tracks[0].artist_string.should == 'Radio Sympa'
      tracks[4].title.should == 'Manhattan'
      # interestingly, the search turns up nothing about QuelqueChoseD'HasBeen :/
    end
    
    should "look up informations about my favorite SomethingALaMode mix" do
      stub_get('http://api.official.fm/track/60526?key=GNXbH3zYb25F1I7KVEEN&format=json&api_embed_codes=', 'track.json')
      track = @client.track(60526)
      # yes, for some reason there's a double-escaped backslash in there. Don't ask, don't tell.
      track.title.should == "QuelqueChosed\'HasBeen"
      track.artist_string.should == 'Various Artist'
    end
    
    should "retrieve a list of 3 users who voted for QuelqueChoseD'HasBeen" do
      stub_get('http://api.official.fm/track/60526/votes?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=3', 'track_votes.json')
      users = @client.track_votes(60526, :limit => 3)
      users[0].city.should == "Geneva"
      users[1].profile.should == "co-founder @official.fm"
      users[2].id.should == 7615
    end
    
    should "retrieve 50 latest tracks from the 'electronic' charts" do
      stub_get('http://api.official.fm/tracks/charts?key=GNXbH3zYb25F1I7KVEEN&format=json&charting=month&genre=&country=&api_embed_codes=&api_max_responses=', 'charts.json')
      tracks = @client.charts('month')
      tracks.length.should == 50 # the API's default
    end
    
    should "retrieve 50 last posted tracks" do
      stub_get('http://api.official.fm/tracks/latest?key=GNXbH3zYb25F1I7KVEEN&format=json&genre=&country=&api_embed_codes=&api_max_responses=', 'charts.json')
      tracks = @client.latest()
      tracks.length.should == 50 # the API's default
    end
  end
  
end
