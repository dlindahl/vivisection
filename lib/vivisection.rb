require 'active_support/core_ext/class/attribute_accessors'

class Vivisection
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
    :template_file => File.dirname( __FILE__) + "/templates/vivisection.mustache"
  }

  #
  @@index_url = nil

  @@ignore = []

  cattr_accessor :destination, :source_files, :rocco_options, :index_url, :ignore
end

require File.dirname(__FILE__) + "/vivisection/tasks"
require File.dirname(__FILE__) + "/tasks/document"
require File.dirname(__FILE__) + "/tasks/link_verification"
