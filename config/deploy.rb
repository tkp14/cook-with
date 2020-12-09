# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "cook-with"
set :repo_url, "git@github.com:tkp14/cook-with.git"

# シンボリックリンクのファイルを指定、具体的にはsharedに入るファイル
append :linked_files, "config/master.key"
# シンボリックリンクのディレクトリを生成
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads", "public/storage"
set :rbenv_type, :user
set :rbenv_ruby, '2.5.7'
# タスクでsudoなどを行う際に必要
set :pty, true
set :keep_releases, 3
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails puma pumactl}
set :rbenv_roles, :all # default value

# puma
set :puma_init_active_record, true
