set :stage, :production
set :rails_env, :production
set :deploy_to, "/var/www/rails/cook-with"

server '52.196.123.212', user: 'takaP', roles: %w{app db web}
