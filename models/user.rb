
# User Object
class User
  include DataMapper::Resource

  property :id,           Serial
  property :username,     String,     :required => true,
                                      :unique   => true
  property :email,        String,     :required => true,
                                      :format   => :email_address
  property :password,     BCryptHash, :required => true
  property :session_key,  BCryptHash, :default  => "#{Time.now.to_s}#{self.username}"
  property :admin,        Boolean,    :default  => false
  timestamps :at

  attr_accessor :password_conf
  validates_confirmation_of :password, :confirm => :password_conf

  ## Helpers ##

  # Authenticate with username and password
  def self.authenticate(auth_username, auth_password)
    user = first(:username => auth_username)
    return nil if     user.nil?
    return nil if     user.password != auth_password
    return nil unless user.update_session_key
    return user
  end

  # Find user by session key
  def self.find_by_session_key(key)
    first(:session_key => key) unless key.nil?
  end

  # Set new session_key
  def update_session_key
    self.session_key = get_session_key
    self.save
  end

  # Is user admin
  def admin?
    self.admin
  end

  def get_session_key
    "#{Time.now.to_s}#{self.username}"
  end
end