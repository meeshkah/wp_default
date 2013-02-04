set :deploy_to, "/home/path/to/playground.example.org/"
server "playground.example.org", :app

namespace :myproject_staging do
    task :symlink, :roles => :app do
        run "ln -nfs #{shared_path}/wp-config.staging.php #{release_path}/application/wp-config.staging.php"
    end
end

after "deploy:symlink", "myproject_staging:symlink"