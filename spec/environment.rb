ENV['RACK_ENV'] = 'test'

require_relative '../bootstrap.rb'
require_relative './fixtures.rb'
require 'test/unit'
require 'rack/test'

# Build DB
class Application < Sinatra::Base
  DataMapper.finalize
  DataMapper.auto_migrate!
end

class Test::Unit::TestCase
  include Rack::Test::Methods
end