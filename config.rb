# Require any additional compass plugins here.
require 'bundler/setup'
Bundler.require(:development)

# Set this to the root of your project when deployed:
http_path       = "/"
css_dir         = "lib/stylesheets/compiled"
sass_dir        = "lib/stylesheets"
# images_dir      = "public/images/customink/style_guide"
# javascripts_dir = "public/javascripts/customink/style_guide"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false
