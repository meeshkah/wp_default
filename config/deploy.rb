set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "your-application-name"
set :repository, "git@github.com:you/your-project.git"
set :scm, :git
set :deploy_to, "/home/path/to/project/"
set :use_sudo, false

set :deploy_via, :remote_cache
set :copy_exclude, [".git", ".DS_Store", ".gitignore", ".gitmodules"]

server "example.org", :app

namespace :myproject do
    task :symlink, :roles => :app do
        run "ln -nfs #{shared_path}/uploads #{release_path}/application/wp-content/uploads"
    end
end

after "deploy:symlink", "myproject:symlink"