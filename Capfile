require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/rails"
require "capistrano/rails/collection"
require "capistrano/rails/console"
require "capistrano/rake"
require "capistrano/rbenv"
require "capistrano/puma"
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx

Dir.glob("lib/capistrano/tasks/*.rb").each { |r| import r }
