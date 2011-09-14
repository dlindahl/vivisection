require 'active_support/all'

module Vivisection
  @@destination   = nil
  @@source_files  = []
  @@rocco_options = {}

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
end

require File.dirname(__FILE__) + "/tasks/document"