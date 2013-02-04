set :deploy_to, "/home/path/to/playground.example.org/"
server "playground.example.org", :app

def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

namespace :myproject_staging do

	desc "test if wp-config.staging.php exists. if not, copy"
	task :missing do
	  if remote_file_exists?('#{shared_path}/wp-config.staging.php')
	    run "cp #{release_path}/application/wp-config.default.php #{shared_path}/wp-config.staging.php"
	  end
	end
	
	dec "link shared config to the current deployment"
    task :symlink, :roles => :app do
        run "ln -nfs #{shared_path}/wp-config.staging.php #{release_path}/application/wp-config.staging.php"
    end
end

after "deploy:symlink", "myproject_staging:symlink"