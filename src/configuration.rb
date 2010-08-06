require 'compass'

# Parse the Compass config
Compass.configuration.parse('config.rb')

# Default is 3000
configuration.preview_server_port = 3042

# Default is localhost
#configuration.preview_server_host = "localhost"
configuration.preview_server_host = '10.5.67.115'
#configuration.preview_server_host = '10.5.65.87'


# Default is true
# When false .html & index.html get stripped off generated urls
configuration.use_extensions_for_page_links = true

# Default is an empty hash
# We use Compass's config
configuration.sass_options = Compass.sass_engine_options
#configuration.sass_options[:debug_info] = true

# Default is an empty hash
# http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#options
configuration.haml_options = {
  #:format => :html5,
  :attr_wrapper => '"'
}