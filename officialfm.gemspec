# -*- encoding: utf-8 -*-
require File.expand_path('../lib/officialfm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'officialfm'
  gem.version = OfficialFM::VERSION
  gem.authors = ["Amos Wenger"]
  gem.email = ['amos@official.fm']
  gem.summary = %q{Official Ruby bindings for the official.fm API}
  gem.description = %q{Official Ruby bindings for the official.fm API}
  gem.post_install_message =<<eos
********************************************************************************

  Follow @ofmdev on Twitter for announcements, updates, and news.
  https://twitter.com/ofmdev

  Don't forget to get your API key here:
  http://official.fm/developers/manager

********************************************************************************
eos
  gem.homepage = 'http://github.com/officialfm/officialfm-ruby'

  gem.add_runtime_dependency 'faraday', '~> 0.6'
  gem.add_runtime_dependency 'faraday_middleware', '~> 0.6'
  gem.add_runtime_dependency 'hashie', '~> 1.0.0'
  gem.add_runtime_dependency 'simple_oauth', '~> 0.1.5'

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'fakeweb', '~> 1.3'
  gem.add_development_dependency 'jnunemaker-matchy', '~> 0.4'
  gem.add_development_dependency 'json_pure', '~> 1.5'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'shoulda', '~> 2.11'
  gem.add_development_dependency 'test-unit', '~> 2.1'

  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if gem.respond_to? :required_rubygems_version=
  gem.platform = Gem::Platform::RUBY
  gem.require_paths = ['lib']
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
end
