require 'rubygems'
require 'bundler/setup'
require 'nokogiri'

require 'net/http'
require 'uri'

desc "Verifies all of the links in the generated documentation"
namespace :vivisection do
  task :verify_links do

    doc_path = Rake.original_dir + "/docs"
    paths = []

    Dir[doc_path + "/**/*.html"].each do |doc|
      Nokogiri::HTML.parse( File.read(doc) ).css('a').each do |link|
        path = link.attribute('href').to_s

        unless path =~ /^#/
          path = File.expand_path( File.dirname(doc) + "/" + path ) unless path =~ /^http/
          paths << path unless paths.include?(path)
        end
      end
    end

    failures = []

    paths.each do |path|
      if path =~ /^http/
        is_live = live_url?(path)
        case is_live
        when true then ok
        when false then fail(path)
        else
          error(path, is_live)
        end
      else
        if File.exists?( path )
          ok
        else
          fail path
        end
      end
    end

    report @@failures, "Paths that did not exists"
    report @@errors, "Paths that generated an error"

    puts "\n"

  end
end

private

def ok
  print "."
  STDOUT.flush
end

@@failures = []
@@errors = []

def fail( path )
  @@failures << path
  print "F"
  STDOUT.flush
end

def error( path, message )
  @@errors << [ path, message ]
  print "E"
  STDOUT.flush
end

def report( paths, message )
  unless paths.empty?
    puts "\n\n"
    puts "#{message}:"
    y paths
  end
end

def live_url?(url)
  uri = URI.parse(url)
  response = nil
  begin
    Net::HTTP.start(uri.host, uri.port) do |http|
      response = http.head(uri.path.size > 0 ? uri.path : "/")
    end
  rescue
    $!.message
  else
    response.code =~ /(200)?(300)?/ ? true : false
  end
end