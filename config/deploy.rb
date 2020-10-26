# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "cook-with"
# デプロイ先の指定
set :deploy_to, "/home/takaP/cook-with"
set :repo_url, "git@github.com:tkp14/cook-with.git"

# ソケットの場所、Nginxとのやり取りに必要
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
# サーバー状態を表すファイルの場所
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# プロセスを表すファイルの場所
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# ログの場所
set :puma_access_log, "#{shared_path}/log/puma.error.log"
set :puma_error_log, "#{shared_path}/log/puma.access.log"
# Rubyをrbenv経由で使う
set :rbenv_type, :user
set :rbenv_ruby, '2.5.7'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# タスクでsudoなどを行う際に必要
set :pty, true
# シンボリックリンクのファイルを指定、具体的にはsharedに入るファイル
append :linked_files, "config/master.key"
# シンボリックリンクのディレクトリを生成
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads", "public/storage"
# 保存しておく過去分のアプリ数
set :keep_releases, 3

namespace :deploy do
  desc 'Create database'
  task :db_create do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rails, 'db:create'
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
