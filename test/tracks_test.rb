require 'helper'

class TracksTest < Test::Unit::TestCase

  context "When using the official.fm API and working with Tracks" do
    setup do
      @client = officialfm_test_client
    end
    
    should "search for 5 tracks with the 'Dare' search term" do
      tracks = @client.tracks('Dare', {:limit => 5})
    end
  end
  
end
