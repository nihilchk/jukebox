ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'yaml'
rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__)

SERVER_CONFIG = YAML.load_file(rails_root + '/server_config.yml')
