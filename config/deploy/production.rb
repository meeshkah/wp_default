set :deploy_to, "/home/path/to/example.org/"
server "example.org", :app

namespace :myproject_production do

	desc "test if wp-config.production.php exists. if not, copy"
    task :missing do
       # if the shared config file does not exist, copy the default config to shared folder
       run "if [[ -f #{shared_path}/wp-config.production.php ]]; then echo 'Config file exists'; else cp #{release_path}/wp-config.default.php #{shared_path}/wp-config.production.php; fi"
    end
	
	dec "link shared config to the current deployment"
    task :symlink, :roles => :app do
        run "ln -nfs #{shared_path}/wp-config.production.php #{release_path}/wp-config.production.php"
    end
end

after "deploy:update_code", "myproject_production:missing", "myproject_production:create_symlink" 