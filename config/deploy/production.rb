server '52.196.123.212', user: "deploy", roles: %w{app db web}

set :stage, :production
set :rails_env, :production
set :deploy_to, "/takaP/cook-with"
