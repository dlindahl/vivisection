# Vivisection

[![Build Status](https://secure.travis-ci.org/dlindahl/vivisection.png)](http://travis-ci.org/dlindahl/vivisection)


## Installation

### Add to Bundler

### Add to Rakefile

    require 'bundler'
    Bundler.setup
    require 'vivisection'

## Configure

    task :vivisection do
      Vivisection.source_files = [
        'lib/**/*.rb',
        'app/**/*.rb',
        'public/javascripts/customink/style_guide/*.js',
        'public/javascripts/customink/style_guide/forms/*.js',
        'public/javascripts/customink/style_guide/progress_bar/*.js'
      ]
    end

#### TODO

  * Template is still very StyleGuide centric.
