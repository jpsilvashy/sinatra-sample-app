require_relative '../environment.rb'

class UserModelTest < Test::Unit::TestCase

  def test_user_class_exists
    assert_not_nil User
  end

  def test_user_class_methods
    assert_respond_to User, :authenticate
    assert_respond_to User, :find_by_session_key
  end

  def test_user_attributes
    @user = User.new
    assert_respond_to @user, :id
    assert_respond_to @user, :username
    assert_respond_to @user, :email
    assert_respond_to @user, :password
    assert_respond_to @user, :session_key
    assert_respond_to @user, :admin
    assert_respond_to @user, :created_at
    assert_respond_to @user, :updated_at
  end

  def test_user_instance_methods
    @user = User.new
    assert_respond_to @user, :update_session_key
    assert_respond_to @user, :admin?
  end

  def test_user_save
    @user = user_rand
    assert @user.save
    assert_not_nil @user.session_key
  end

  def test_user_errors
    @user = User.new
    assert_equal false, @user.save
    assert has_error? @user, 'Username must not be blank'
    assert has_error? @user, 'Email must not be blank'
    assert has_error? @user, 'Password must not be blank'
  end

  def test_user_authenticate
    @user = user_rand
    assert @user.save
    assert_nil User.authenticate('bad_username', 'passw0rd')
    assert_nil User.authenticate(@user.username, 'bad_password')
    assert_equal @user, User.authenticate(@user.username, 'passw0rd')
  end

  def test_session_key_management
    @user = user_rand
    assert @user.save
    assert_not_nil @user.session_key
    old_session_key = @user.session_key
    assert @user.update_session_key
    assert_not_nil @user.session_key
    assert_not_equal old_session_key, @user.session_key
  end

  def test_find_by_session_key
    @user = user_rand
    assert @user.save
    assert_equal @user, User.find_by_session_key(@user.session_key)
  end

  def test_admin_role
    @user = user_rand
    assert_equal false, @user.admin
    @user.admin = true
    @user.save
    assert_equal true, @user.admin
  end

  # Helpers #

  def has_error?(user, error_msg)
   ! (user.errors.full_messages.join =~ /#{error_msg}/).nil?
  end

end