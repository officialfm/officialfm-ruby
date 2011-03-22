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
      user = @client.users('chab', {:limit => 1})[0]
      user.name.should == 'Chab'
      user.gender.should == 'male'
      user.status.should == 'artist'
      # let's hope he doesn't move away
      user.country_id.should == 'CH'
    end
    
    should "retrieve the first two tracks of chab" do
      stub_get('http://api.official.fm/user/chab/tracks?key=GNXbH3zYb25F1I7KVEEN&format=json&api_embed_codes=&api_max_responses=2', 'user_tracks.json')
      tracks = @client.user_tracks('chab', {:limit => 2})
      tracks.size.should == 2
      tracks[0].title.should == 'Blind (Chab Remix)'
      tracks[0].artist_string.should == 'Hercules and Love Affair'
    end
    
    should "retrieve the first two playlists of chab" do
      stub_get('http://api.official.fm/user/chab/playlists?key=GNXbH3zYb25F1I7KVEEN&format=json&api_embed_codes=&api_max_responses=2', 'user_playlists.json')
      playlists = @client.user_playlists('chab', {:limit => 2})
      playlists.size.should == 2
      playlists[0].name.should == 'I like'
      playlists[1].user_id.should == 8735 # chab's user id
    end
    
    should "retrieve the first two contacts of chab" do
      stub_get('http://api.official.fm/user/chab/contacts?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=2', 'user_contacts.json')
      contacts = @client.user_contacts('chab', {:limit => 2})
      contacts.size.should == 2
      contacts[0].name.should == 'Mental Groove Records'
      contacts[1].status.should == 'artist'
    end
    
    should "retrieve the first two subscribers of chab" do
      stub_get('http://api.official.fm/user/chab/subscribers?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=2', 'user_subscribers.json')
      subscribers = @client.user_subscribers('chab', {:limit => 2})
      subscribers.size.should == 2
      subscribers[0].id.should == 394
      subscribers[1].name.should == 'jenny'
    end
    
    should "retrieve the first two subscriptions of chab" do
      stub_get('http://api.official.fm/user/chab/subscriptions?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=2', 'user_subscriptions.json')
      subscriptions = @client.user_subscriptions('chab', {:limit => 2})
      subscriptions.size.should == 2
      subscriptions[0].profile.should == 'Freelance CTO, Junior tastemaker!'
      subscriptions[1].url.should == 'http://www.myspace.com/sumomusic'
    end

  end

end
