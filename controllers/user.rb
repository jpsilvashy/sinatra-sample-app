# User Controller
class Application < Sinatra::Base
 
  # List all users
  get '/users/?' do
    @users = User.all
    @title = 'All Users'
    erb :'user/list'
  end

  # Create a new user FORM
  get '/users/create/?' do
    @title = 'Sign Up'
    erb :'user/create'
  end

  # Create new user ACTION
  post '/users/create/?' do
    @user = User.new
    @user.username      = params[:username].downcase
    @user.email         = params[:email]
    @user.password      = params[:password]
    @user.password_conf = params[:password_conf]

    return erb :'user/create'             unless @user.valid?
    flash[:success] = "User created"      if     @user.save
    flash[:error]   = "User not created"  unless @user.save
    redirect "/users"
  end

  # View a user
  get '/user/:uname/?' do
    @user = find_user(params[:uname])
    @title = "#{@user.username.capitalize} Profile"
    erb :'user/view'
  end

  # Edit a user FORM
  get '/user/:uname/edit/?' do
    @user = find_user(params[:uname])
    @title = "#{@user.username.capitalize} Properties"
    erb :'user/edit'
  end

  # Edit a user ACTION
  post '/user/:uname/edit/?' do
    @user = find_user(params[:uname])
    @user.username      = params[:username].downcase
    @user.email         = params[:email]
    @user.password      = params[:password]
    @user.password_conf = params[:password_conf]

    return erb :"user/edit"               unless @user.valid?
    flash[:success] = "Changes Saved"     if     @user.save
    flash[:error]   = "Changes not saved" unless @user.save
    redirect "user/#{@user.username}/edit"
  end

  # Delete a user
  get '/user/:uname/delete/?' do
    @user = find_user(params[:uname])
    flash[:success] = "User Deleted"      if     @user.destroy
    flash[:error]   = "User Not Deleted"  unless @user.destroy
    redirect "/users"
  end

  ## Helper Methods ##

  # Safely find a user by username
  def find_user(uname)
    user = User.first(:username => uname)
    return user unless user.nil?
    flash[:warning] = "User #{uname} does not exist"
    redirect '/users'
  end
end