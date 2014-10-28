set :deploy_to, "/srv/www/#{application}_staging"
server "staging.example.org", :web, :app, :db, primary: true

# Disable APC cache for staging
# set :with_apc, false



namespace :wp_staging do

	desc "Copy wp-config.staging.php if doesn't exist"
    task :missing, roles: :app do
      unless remote_file_exists? "#{shared_path}/wp-config.staging.php"
        set :mysql_password, remote_file_exists?("/tmp/mysql_pass") ? remote_file_read("/tmp/mysql_pass") : mysql_entered_password
        template "app.erb", "#{shared_path}/wp-config.staging.php"
        if remote_file_exists? "/tmp/mysql_pass"
          run "#{sudo} rm /tmp/mysql_pass && echo \"Temporary password file deleted. Config set up\"" 
        else 
          "Config set up"
        end
      else
        puts "Config file already exists, carrying on..."
      end
    end
	
	desc "Link shared config to the current deployment"
    task :symlink, roles: :app do
        run "ln -nfs #{shared_path}/wp-config.staging.php #{release_path}/wp-config.staging.php"
    end
end

after "deploy:update_code", "wp_staging:missing", "wp_staging:symlink" 