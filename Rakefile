require 'rake'
require "shoulda/tasks"
require "rake/testtask"
require 'bundler'

Bundler::GemHelper.install_tasks

Rake::TestTask.new(:test) do |test|
  test.ruby_opts = ["-rubygems"] if defined? Gem
  #test.ruby_opts << "-w"
  test.libs << "lib" << "test"
  test.pattern = "test/**/*_test.rb"
end

task :default => :test
