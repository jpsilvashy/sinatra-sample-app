source :rubygems

gem 'rake'
gem 'thin'
gem 'sinatra', :require => 'sinatra/base'
gem 'sinatra-flash', :require => 'sinatra/flash'
gem 'data_mapper'

group :development do
  gem 'dm-sqlite-adapter'
end

group :test do
  gem 'dm-sqlite-adapter'
  gem 'rack-test'
end

group :production do
  gem 'dm-postgres-adapter'
end