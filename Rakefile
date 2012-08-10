require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'rake/testtask'

# Default to all tests
task :default => 'test:all'

# Testing
namespace :test do
  # Run all tests
  task :all => [:models, :controllers]

  # Model tests
  desc 'Run model tests'
  Rake::TestTask.new('models') do |t|
    t.libs << 'spec'
    t.test_files = FileList['spec/models/*_spec.rb']
  end

  # Controller tests
  desc 'Run controller tests'
  Rake::TestTask.new('controllers') do |t|
    t.libs << 'spec'
    t.test_files = FileList['spec/controllers/*_spec.rb']
  end
end

# Development server management
namespace :dev do
  desc 'Start in development mode'
  task :start do
    system 'thin -e development start'
  end
end

# Production server management
namespace :live do
  desc 'Start production processes, or process on [port]'
  task :start, [:port] do |t, args|
    system "thin -C thin-production-config.yml -o #{args.port} start" if args.port
    system 'thin -C thin-production-config.yml start' unless args.port
  end

  desc 'Stop production processes, or process on [port]'
  task :stop, [:port] do |t, args|
    system "thin -C thin-production-config.yml -o #{args.port} stop" if args.port
    system 'thin -C thin-production-config.yml stop' unless args.port
  end

  desc 'Restart production processes one-by-one'
  task :restart do
    system 'thin -C thin-production-config.yml restart'
  end

  desc 'Show production process status'
  task :status do
    puts 'Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name'
    system 'netstat -tnlp 2>/dev/null | grep thin'
  end
end

# Log file management
namespace :logs do
  desc 'Purge all logs'
  task :purge do
    system 'rm -f log/*.log'
  end

  desc 'View end of log files'
  task :tail do
    system 'tail log/*.log'
  end
end

# Database management
namespace :db do
  desc 'Auto-migrate the database (destroys data)'
  task :migrate do
    puts "Bootstrapping database (destroys data)..."
    require_relative 'bootstrap.rb'
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  desc 'Auto-upgrade the database (preserves data)'
  task :upgrade do
    puts "Upgrading database (preserves data)..."
    require_relative 'bootstrap.rb'
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end

  desc 'Populate the database'
  task :populate do
    puts "Creating an admin user..."
    require_relative 'bootstrap.rb'
    class Application < Sinatra::Base
      @user = User.new
      @user.username  = 'admin'
      @user.email     = 'admin@example.com'
      @user.password_conf = \
      @user.password  = 'passw0rd'
      @user.admin     =  true
      puts 'Created admin user' if     @user.save
    end
  end
end