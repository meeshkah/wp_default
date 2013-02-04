set :deploy_to, "/home/path/to/example.org/"
server "example.org", :app

namespace :myproject_production do
    task :symlink, :roles => :app do
        run "touch #{release_path}/env_production"
    end
end

after "deploy:symlink", "myproject_production:symlink"