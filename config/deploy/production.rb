server '52.196.123.212', user: "takaP", roles: %w{app db web}

set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true
}
