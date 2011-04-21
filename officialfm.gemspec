# -*- encoding: utf-8 -*-
require File.expand_path('../lib/officialfm/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'officialfm'
  s.version = OfficialFM::VERSION
  s.authors = ["Amos Wenger"]
  s.email = ['amos@official.fm']
  s.summary = %q{Official Ruby bindings for the official.fm API}
  s.description = %q{Official Ruby bindings for the official.fm API}
  s.homepage = 'http://github.com/officialfm/officialfm-ruby'

  s.add_runtime_dependency 'faraday', '~> 0.5.3'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.3.0'
  s.add_runtime_dependency 'hashie', '~> 1.0.0'

  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'fakeweb', '~> 1.3'
  s.add_development_dependency 'jnunemaker-matchy', '~> 0.4'
  s.add_development_dependency 'json_pure', '~> 1.4'
  s.add_development_dependency 'rake', '~> 0.8'
  s.add_development_dependency 'shoulda', '~> 2.11'
  s.add_development_dependency 'test-unit', '~> 2.1'

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if s.respond_to? :required_rubygems_version=
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
end
