require 'rocco/tasks'

class Vivisection
  class Task < Rocco::Task

    # This initializer is copied straight from Rocoo with the addition of
    # adding support for exclusing any ignored file patterns from the list
    # of source files.
    def initialize(task_name, dest='docs/', sources='lib/**/*.rb', options={})
      @name = task_name
      @dest = dest[-1] == ?/ ? dest : "#{dest}/"
      @sources = FileList[sources]
      @options = options

      # Don't include ignored files as part of the source file list.
      Vivisection.ignore.each { |pattern| @sources.exclude(pattern) }

      # Make sure there's a `directory` task defined for our destination.
      define_directory_task @dest

      # Run over the source file list, constructing destination filenames
      # and defining file tasks.
      @sources.each do |source_file|
        dest_file = source_file.sub(Regexp.new("#{File.extname(source_file)}$"), ".html")
        define_file_task source_file, "#{@dest}#{dest_file}"

        # If `rake/clean` was required, add the generated files to the list.
        # That way all Rocco generated are removed when running `rake clean`.
        CLEAN.include "#{@dest}#{dest_file}" if defined? CLEAN
      end
    end

    # Rocco determines if a source file needs to be updated based on the contents
    # of the file as well as its own internal source code.
    # This patches in Vivisection's source code as well.
    def rocco_source_files
      libdir = File.expand_path('../..', __FILE__)
      (super + FileList["#{libdir}/vivisection.rb", "#{libdir}/tasks/**", "#{libdir}/templates/**"]).tap do |files|
        Vivisection.ignore.each { |pattern| files.exclude(pattern) }
      end
    end

    # Monkey patch support for ignoring certain files.
    def define_file_task(source_file, dest_file)
      super unless Vivisection.ignore.any? { |ig_rex| source_file =~ ig_rex }
    end

  end
end
