require 'rubygems'
require 'bundler'
Bundler.setup
require 'coffee-script'
require 'rack'
require 'rack/contrib/try_static'
require 'jekyll'
require 'sass/plugin/rack'
require 'rack/sprockets'

require 'barista'

class MrHyde
  def initialize(app)
    @jekyll = Jekyll::Site.new(Jekyll.configuration({}))
    @app = app
  end
  def call(env)
    @jekyll.process
    @app.call(env)
  end
end
use Sass::Plugin::Rack
Sass::Plugin.options[:css_location] = "./css" 
Sass::Plugin.options[:template_location] = "./_sass"

# The project root directory
root = ::File.dirname(__FILE__)

# Barista (for CoffeeScript Support)
Barista.app_root = root
Barista.setup_defaults
Barista.bare = true
Barista.root     = '_coffee'
Barista.output_root =  '_javascripts'
use Barista::Filter


use Rack::Sprockets,
      :load_path => '_javascripts/libs',
      :hosted_at => '/js',
      :source => '_javascripts'

use MrHyde
use Rack::TryStatic, 
    :root => "_site",  # static files root dir
    :urls => %w[/],     # match all requests 
    :try => ['.html', 'index.html', '/index.html'] # try these postfixes sequentially
# otherwise 404 NotFound
run lambda { [404, {'Content-Type' => 'text/html'}, ['whoops! Not Found']]}

