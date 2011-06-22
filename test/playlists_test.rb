require 'helper'

class PlaylistsTests < Test::Unit::TestCase

  context "When using the official.fm API and working with Playlists" do
    setup do
      @client = officialfm_test_client
    end
    
    should "search for 5 playlists with the 'R&B Mixtape' search term" do
      stub_get('http://api.official.fm/search/playlists/R%26B+Mixtape?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=5', 'playlists.json')
      tracks = @client.playlists('R&B Mixtape', :limit => 5)
      tracks.length.should == 5
      tracks[0].running_time.should == 4167
      tracks[4].tracks[3].should == 12818
    end
    
    should "get info on HLSTRS Timeless mixtape" do
      stub_get('http://api.official.fm/playlist/55569?key=GNXbH3zYb25F1I7KVEEN&format=json&api_embed_codes=', 'playlist.json')
      playlist = @client.playlist(55569)
      playlist.shuffle.should == false
      playlist.user_id.should == 46269
    end
    
    should "get playlist votes on HLSTRS Timeless mixtape" do
      stub_get('http://api.official.fm/playlist/55569/votes?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=', 'playlist_votes.json')
      votes = @client.playlist_votes(55569)
      votes[0].name.should == 'VALERIAN'
    end
  end
  
end
