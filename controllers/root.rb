
# Controller for routes from the root
class Application < Sinatra::Base

  # Root path
  get '/' do
    @title = 'Home'
    @greeting = 'Hello World!'
    erb :index
  end

  ## Root Path Aliases ##
  get '/signup/?' do; get_alias '/users/create';    end
  get '/login/?'  do; get_alias '/session/create';  end
  get '/logout/?' do; get_alias '/session/destroy'; end


  ## Feature Demos ##

  # Accessible only to admins
  get '/demo/admin_only' do
    if current_user_admin?
      erb "You are logged in as admin"
    else
      erb "You are either not logged in, or not an admin"
    end
  end

  # Accessible only to specified user or admin
  get '/demo/access_only_:uname' do
    if current_user_is? params[:uname]
      erb "You are either #{params[:uname]} or an admin"
    else
      erb "You are not logged in, not #{params[:uname]} or not an admin"
    end
  end


  ## Error Pages ##

  # 404 error
  not_found do
    @title    = '404'
    @code     =  404
    @message  = 'Page not found'
    erb :error
  end

  # General error
  error do
    @title    = '500'
    @code     =  500
    @message  = 'An unknown error has occurred'
    erb :error
  end
end