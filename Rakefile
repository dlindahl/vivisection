# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "vivisection"
  gem.homepage = "http://github.com/dlindahl/vivisection"
  gem.license = "MIT"
  gem.summary = %Q{A CustomInk Rocco Theme}
  gem.description = %Q{A Rocco theme that is branded for CustomInk.com}
  gem.email = "dlindahl@customink.com"
  gem.authors = ["Derek Lindahl"]
  # dependencies defined in Gemfile
  gem.add_dependency 'pygmentize',  '~> 0.0.3'
  gem.add_dependency 'rocco',       '~> 0.8.1'
  gem.add_dependency 'nokogiri',    '>= 1.4'

  gem.add_development_dependency "activesupport", ">= 2"
  gem.add_development_dependency "compass", "~> 0.11.3"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test
