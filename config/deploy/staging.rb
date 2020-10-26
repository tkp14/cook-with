
set :stage, :staging
set :rails_env, 'production'
set :migration_role, 'db'
# サーバー、ユーザー、ロールの指定
server "52.196.123.212", user: "takaP", roles: %w{app db web}
 
# デプロイ先のリポジトリ指定
set :repo_url, "/home/takaP/cook-with.git"
 
# デプロイするブランチ指定
set :branch, 'how_to_capistrano'
 
# SSHの設定
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}
