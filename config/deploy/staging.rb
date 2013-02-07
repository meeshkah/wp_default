set :deploy_to, "/home/path/to/playground.example.org/"
server "playground.example.org", :app

namespace :myproject_staging do

	desc "test if wp-config.staging.php exists. if not, copy"
    task :missing do
       # if the shared config file does not exist, copy the default config to shared folder
       run "if [[ -f #{shared_path}/wp-config.staging.php ]]; then echo 'Config file exists'; else cp #{release_path}/wp-config.default.php #{shared_path}/wp-config.staging.php; fi"
    end
	
	dec "link shared config to the current deployment"
    task :symlink, :roles => :app do
        run "ln -nfs #{shared_path}/wp-config.staging.php #{release_path}/wp-config.staging.php"
    end
end

after "deploy:update_code", "myproject_staging:missing", "myproject_staging:create_symlink" 