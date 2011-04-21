require 'faraday'
require 'faraday_middleware'

directory = File.expand_path(File.dirname(__FILE__))

module OfficialFM

  class << self
    attr_accessor :api_key
    attr_accessor :test_mode

    # Configures default credentials easily
    # @yield [api_key]
    def configure
      yield self
      true
    end

    def test_mode?
      !!self.test_mode
    end
  end

  require 'officialfm/users'
  require 'officialfm/tracks'
  require 'officialfm/playlists'
  require 'officialfm/client'

end
