require_relative '../environment.rb'

class UserControllerTest < Test::Unit::TestCase

  def app
    Application
  end

  def test_user_list_responds
    get '/users/'
    assert last_response.ok?
  end
end