require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
Bundler.require

class Application < Sinatra::Base
  register Sinatra::Flash

  puts "=> Running in #{settings.environment} environment"

  ## Sinatra Settings ##
  # http://www.sinatrarb.com/configuration.html
  enable :sessions

  configure :development do
    Bundler.require :development
    use Rack::CommonLogger
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup :default, "sqlite:database.db"
  end

  configure :test do
    Bundler.require :test
    DataMapper.setup :default, "sqlite::memory:"
  end

  configure :production do
    Bundler.require :production
    DataMapper.setup :default, ENV['DATABASE_URL']
  end

end

# Helper Libraries
require_relative 'lib/global.rb'          # General helpers for views & controllers

# Model Classes
require_relative 'models/user.rb'         # A generic User model

# Controller Routes
require_relative 'controllers/root.rb'    # Routes for the root
require_relative 'controllers/user.rb'    # User controller
require_relative 'controllers/session.rb' # Session controller