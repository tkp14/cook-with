server '52.196.123.212', user: "takaP", roles: %w{app db web}

set :ssh_options, {
  keys: ["#{ENV.fetch('PRODUCTION_SSH_KEY')}"],
  forward_agent: true,
  auth_methods: [publickey]
}
