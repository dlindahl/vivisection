require 'rubygems'
require 'bundler/setup'
require 'nokogiri'

require 'net/http'
require 'uri'

@@doc_path = Rake.original_dir + "/docs"
@@failures = []
@@errors = []

desc "Verifies all of the links in the generated documentation"
namespace :vivisection do
  task :verify_links do

    paths = {}

    Dir[@@doc_path + "/**/*.html"].each do |doc|
      Nokogiri::HTML.parse( File.read(doc) ).css('a').each do |link|
        path = link.attribute('href').to_s

        unless path =~ /^#/
          path = File.expand_path( File.dirname(doc) + "/" + path ) unless path =~ /^http/
          paths[path] = doc unless paths.has_key?(path)
        end
      end
    end

    failures = []

    paths.each do |path, doc|
      if path =~ /^http/
        is_live = live_url?(path)
        case is_live
        when true then ok
        when false then fail(path, doc)
        else
          error(path, doc, is_live)
        end
      else
        if File.exists?( path )
          ok
        else
          fail(path, doc)
        end
      end
    end

    report @@failures, "Paths that did not exist"
    report @@errors, "Paths that generated an error"

    puts "\n"

  end
end

private

def ok
  print "."
  STDOUT.flush
end

def fail( path, doc )
  @@failures << [ path, doc ]
  print "F"
  STDOUT.flush
end

def error( path, doc, message )
  @@errors << [ path, doc, message ]
  print "E"
  STDOUT.flush
end

def report( paths, message )
  unless paths.empty?
    puts "\n\n"
    puts "#{message}:"
    paths.each_with_index do |(path, doc), index|
      path = trim_root( path, Rake.original_dir )
      doc  = trim_root( doc, Rake.original_dir )
      puts "#{index}: #{doc} is linking to #{path}"
    end
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

def trim_root(abs_path, relative_to)
  abs_path.gsub(relative_to + "/", '')
end