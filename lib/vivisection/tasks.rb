require 'rocco/tasks'

module Vivisection
  class Task < Rocco::Task

    # Rocco determines if a source file needs to be updated based on the contents
    # of the file as well as its own internal source code.
    # This patches in Vivisection's source code as well.
    def rocco_source_files
      libdir = File.expand_path('../..', __FILE__)
      super + FileList["#{libdir}/vivisection.rb", "#{libdir}/tasks/**", "#{libdir}/templates/**"]
    end

  end
end
