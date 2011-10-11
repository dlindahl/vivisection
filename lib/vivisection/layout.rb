require 'active_support/core_ext/module/aliasing'

class Rocco::Layout < Mustache

  # Allows the configuration of the page title.
  def title_with_app_title
    [ Vivisection.application_title, title_without_app_title ].compact.join(' - ')
  end
  alias_method_chain :title, :app_title

end
