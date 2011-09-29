# # Documentation Tasks

#
begin
  require 'rocco/tasks'

  # Override this task to apply custom configurations to Vivisection.
  task :configure_vivisection do
  end

  task :initialize_vivisection => [:configure_vivisection] do
    Vivisection::Task.new( :vivisection, Vivisection.destination, Vivisection.source_files, Vivisection.rocco_options )
  end

  desc 'Generate annotated source code using Rocco and Vivisection'
  task :docs => [:initialize_vivisection] do
    Rake::Task[:vivisection].invoke
  end

  # Alias for docs task
  task :doc => :docs

  desc 'Update gh-pages branch'
  # task :pages => ['docs/.git', :docs] do
  task :pages => [:initialize_vivisection, :git_init, :docs, :create_index] do
    rev = `git rev-parse --short HEAD`.strip
    Dir.chdir 'docs' do
      sh "git add *"
      sh "git commit -m 'rebuild pages from #{rev}'" do |ok,res|
        if ok
          verbose { puts "gh-pages updated" }
          sh "git push -q o HEAD:gh-pages"
        end
      end
    end
  end



  task :git_init do
    git_dot_file = Vivisection.destination + ".git"

    directory Vivisection.destination

    file git_dot_file => [Vivisection.destination, '.git/refs/heads/gh-pages'] do |f|
      sh "cd #{Vivisection.destination} && git init -q && git remote add o ../.git" if !File.exist?(f.name)
      # sh "cd #{Vivisection.destination} && git fetch -q o && git reset -q --hard o/gh-pages && touch ."
    end

    Rake::Task[git_dot_file].invoke

    # Always pull before compiling?
    sh "cd #{Vivisection.destination} && git fetch -q o && git reset -q --hard o/gh-pages && touch ."

    CLOBBER.include git_dot_file
  end

  task :create_index do
    if gem?
      gem_file   = Vivisection.destination + "lib/#{gemname}.html"
      index_file = Vivisection.destination + "lib/index.html"

      file index_file do |f|
        cp gem_file, index_file, :preserve => true
      end
      Rake::Task[index_file].invoke
      CLEAN.include index_file

      redirect_file = Vivisection.destination + "index.html"
      file redirect_file do |f|
        # TODO: It'd be cool if this could parse the Gemspec for the homepage value.
        sh %Q(echo '<meta http-equiv="refresh" content="0; url=/#{gemname}/lib/">' > #{redirect_file})
      end
      Rake::Task[redirect_file].invoke
      CLEAN.include redirect_file
    else
      puts "NOTE: Index file generation is not yet implemented for non-Gems. You'll have to create those yourself."
    end
  end

private

  def gem?
    not Dir.glob('*.gemspec').empty?
  end

  def gemname
    File.basename( Dir.glob('*.gemspec').first, ".gemspec" )
  end

rescue LoadError
  warn "#$! — rocco tasks not loaded."
  task :rocco
end
