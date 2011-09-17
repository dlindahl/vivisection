module Vivisection
  #
  @@destination   = 'docs/'

  #
  @@source_files  = [
    'lib/**/*.rb',
    'app/**/*.rb',
    'public/javascripts/**/*.js'
  ]

  #
  @@rocco_options = {
    :template_file => File.dirname( __FILE__) + "/../templates/vivisection.mustache"
  }

  #
  @@index_url = nil

  def self.destination=( dest )
    @@destination = dest
  end

  def self.destination
    @@destination
  end

  def self.source_files=( sources )
    @@source_files = sources
  end

  def self.source_files
    @@source_files
  end

  def self.rocco_options
    @@rocco_options
  end

  def self.index_url=( path )
    @@index_path = path
  end

  def self.index_url
    @@index_path
  end
end

require File.dirname(__FILE__) + "/vivisection/tasks"
require File.dirname(__FILE__) + "/tasks/document"
