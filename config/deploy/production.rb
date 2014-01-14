set :deploy_to, "/srv/www/#{application}"
server "example.org", :web, :app, :db, :mail, primary: true

namespace :wp_production do

  desc "Test if wp-config.production.php exists, then copy and setup, if it doesn't"
    task :missing, roles: :app do
      unless remote_file_exists? "#{shared_path}/wp-config.production.php"
        set :mysql_password, remote_file_exists?("/tmp/mysql_pass") ? remote_file_read("/tmp/mysql_pass") : mysql_entered_password
        template "app.erb", "#{shared_path}/wp-config.production.php"
        run "#{sudo} rm /tmp/mysql_pass && echo \"Temporary password file deleted\""
      else
        puts "Config file already exists, carrying on..."
      end
    end
  
  desc "Link shared config to the current deployment"
    task :symlink, roles: :app do
        run "ln -nfs #{shared_path}/wp-config.production.php #{release_path}/wp-config.production.php"
    end
end

after "deploy:update", "wp_production:missing", "wp_production:symlink" 