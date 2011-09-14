# # Documentation Tasks

#
begin
  require 'rocco/tasks'

  task :vivisection do
    Vivisection.destination = 'docs/'

    Vivisection.source_files = [
      'lib/**/*.rb',
      'app/**/*.rb',
      'public/javascripts/**/*.js'
    ]
  end
  task :configure_vivisection => :vivisection

  task :generate_docs do
    Rocco::Task.new( :rocco, Vivisection.destination, Vivisection.source_files, Vivisection.rocco_options )
    Rake::Task[:rocco].invoke
  end

  desc 'Generate annotated source code using Rocco and Vivisection'
  task :docs => [:configure_vivisection, :generate_docs]
  # directory 'docs/'

  # Alias for docs task
  task :doc => :docs

  # desc 'Update gh-pages branch'
  # task :pages => ['docs/.git', :docs] do
  #   rev = `git rev-parse --short HEAD`.strip
  #   Dir.chdir 'docs' do
  #     sh "git add *.html"
  #     sh "git add app"
  #     sh "git add lib"
  #     sh "git add public"
  #     sh "git commit -m 'rebuild pages from #{rev}'" do |ok,res|
  #       if ok
  #         verbose { puts "gh-pages updated" }
  #         sh "git push -q o HEAD:gh-pages"
  #       end
  #     end
  #   end
  # end

  # Update the pages/ directory clone
  # file 'docs/.git' => ['docs/', '.git/refs/heads/gh-pages'] do |f|
  #   sh "cd docs && git init -q && git remote add o ../.git" if !File.exist?(f.name)
  #   sh "cd docs && git fetch -q o && git reset -q --hard o/gh-pages && touch ."
  # end
  # CLOBBER.include 'docs/.git'

  # Make index.html a copy of style_guide.html
  # TODO: Make this app agnostic
  # file 'docs/lib/index.html' => 'docs/lib/style_guide.html' do |f|
  #   cp 'docs/lib/style_guide.html', 'docs/lib/index.html', :preserve => true
  # end
  # task :docs => 'docs/lib/index.html'
  # CLEAN.include 'docs/lib/index.html'

rescue LoadError
  warn "#$! — rocco tasks not loaded."
  task :rocco
end
