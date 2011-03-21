require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'matchy'
require 'fakeweb'
begin require 'redgreen'; rescue LoadError; end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'officialfm'

FakeWeb.allow_net_connect = false

def officialfm_test_client
  OfficialFM::Client.new(:api_key => 'GNXbH3zYb25F1I7KVEEN')
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def officialfm_url(url)
  url =~ /^http/ ? url : "http://api.official.fm#{url}"
end

def stub_get(url, filename, options={})
  opts = {
    :body => fixture_file(filename),
    :content_type => 'application/json; charset=utf-8'
  }.merge(options)
  FakeWeb.register_uri(:get, officialfm_url(url), opts)
end

def stub_post(url, filename, options={})
  opts = {
    :body => fixture_file(filename),
    :content_type => 'application/json; charset=utf-8'
  }.merge(options)
  FakeWeb.register_uri(:post, officialfm_url(url), opts)
end
