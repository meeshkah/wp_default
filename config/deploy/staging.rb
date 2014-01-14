set :deploy_to, "/srv/www/#{application}_staging"
server "staging.example.org", :web, :app, :db, primary: true

# Disable APC cache for staging
# set :with_apc, false



namespace :wp_staging do

	desc "Copy wp-config.staging.php if doesn't exist"
    task :config, roles: :app do
       # if the shared config file does not exist, copy the default config to shared folder
       run "if [[ -f #{shared_path}/wp-config.staging.php ]]; then echo 'Config file exists'; else cp #{release_path}/wp-config.default.php #{shared_path}/wp-config.staging.php; fi"
    end
	
	desc "Link shared config to the current deployment"
    task :symlink, roles: :app do
        run "ln -nfs #{shared_path}/wp-config.staging.php #{release_path}/wp-config.staging.php"
    end
end

after "deploy:update_code", "staging:missing", "staging:symlink" 