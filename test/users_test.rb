require 'helper'

class UsersTest < Test::Unit::TestCase

  context "When using the official.fm API and working with Users" do
    setup do
      @client = officialfm_test_client
    end

    should "retrieve information about a specific user" do
      stub_get('http://api.official.fm/user/chab?key=GNXbH3zYb25F1I7KVEEN&format=json', 'user.json')
      user = @client.user('chab')
      user.name.should == 'Chab'
      # let's hope he doesn't change sex
      user.gender.should == 'male'
      user.status.should == 'artist'
      user.country_id.should == 'CH'
    end
    
    should "retrieve information about a specific user as well" do
      stub_get('http://api.official.fm/search/users/chab?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=1', 'user.json')
      # this should work as well, 'chab' is an exact match so the first result oughta be correct
      user = @client.users('chab', limit=1)[0]
      user.name.should == 'Chab'
      user.gender.should == 'male'
      user.status.should == 'artist'
      # let's hope he doesn't move away
      user.country_id.should == 'CH'
    end
    
    should "retrieve the first two tracks of chad" do
      stub_get('http://api.official.fm/user/chab/tracks?key=GNXbH3zYb25F1I7KVEEN&format=json&api_embed_codes=&api_max_responses=2', 'user_tracks.json')
      tracks = @client.user_tracks('chab', limit=2)
      tracks.size.should == 2
      tracks[0].name.should != nil
    end

  end

end
