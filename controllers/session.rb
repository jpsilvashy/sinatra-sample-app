# Session (login) Controller
class Application < Sinatra::Base

  # Create new session FORM
  get '/session/create/?' do
    @title = 'Log In'
    erb :'session/create'
  end

  # Create new session ACTION
  post '/session/create/?' do
    @user = User.authenticate(params[:username], params[:password])
    if @user.nil?
      flash.now[:error] = "Incorrect username or password"
      erb :'session/create'
    else
      create_session @user
      redirect "/"
    end
  end

  # Destroy session
  get '/session/destroy/?' do
    destroy_session
    flash[:message] = "You have been logged out"
    redirect "/"
  end

  ## Helper Methods ##

  # Create a session for user
  def create_session(user)
    session[:user_key] = user.session_key
  end

  # End the current user session
  def destroy_session
    session.delete(:user_key)
  end

  # Is a user authenticated?
  def authenticated?
    ! current_user.nil?
  end

  # Is current user an admin?
  def current_user_admin?
    return false if current_user.nil?
    return current_user.admin?
  end

  # Is current user known or admin
  def current_user_is?(uname)
    return false if current_user.nil?
    return true  if current_user_admin?
    return uname == current_user.username
  end

  # Get the current user from session key
  def current_user
    User.find_by_session_key(session[:user_key])
  end
end