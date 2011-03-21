require 'helper'

class UsersTest < Test::Unit::TestCase

  context "When using the official.fm API and working with Users" do
    setup do
      @client = officialfm_test_client
    end

    should "retrieve information about a specific user" do
      stub_get('http://api.official.fm/user/chad?key=GNXbH3zYb25F1I7KVEEN&format=json', 'user.json')
      user = @client.user('chad')
      user.name.should == 'chad'
      # let's hope he doesn't upate his profile
      user.profile.should == "Hi, I'm Chad.  I absolutely love music and movies.  I am in college, and plan to major in Advertising / Marketing / Public Relations.  Have a great day!"
      user.status.should == 'member'
    end
    
    should "retrieve information about a specific user as well" do
      stub_get('http://api.official.fm/search/users/chad?key=GNXbH3zYb25F1I7KVEEN&format=json&api_max_responses=1', 'user.json')
      # this should work as well, 'chad' is an exact match so the first result oughta be correct
      user = @client.users('chad', limit=1)[0]
      user.name.should == 'chad'
      user.profile.should == "Hi, I'm Chad.  I absolutely love music and movies.  I am in college, and plan to major in Advertising / Marketing / Public Relations.  Have a great day!"
      user.status.should == 'member'
    end

  end

end
