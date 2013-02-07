set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :application, "your-application-name"
set :repository, "git@github.com:you/your-project.git"
set :scm, "git"
set :branch, "master"
set :git_enable_submodules, 1
#set :scm_command, "~/bin/git" # Specifies the path to git on the REMOTE
							  # machine.
#set :local_scm_command, "git" # Specifies the local git command. Needs
							  # to be present if remote is present
set :use_sudo, false
#set :user, "user"
set :port, 22 # redundant if ssh port is 22 (default), yet useful if not.
			  # change accordingly

set :deploy_via, :remote_cache
#set :copy_exclude, [".git", ".DS_Store", ".gitignore", ".gitmodules"] # Uncomment if you
																	  # have permissions
																	  # to use rsync remotely

namespace :deploy do
  
  desc "creating release directory"
  task :create_release_dir, :except => {:no_release => true} do
    run "mkdir -p #{fetch :releases_path} && chmod g-w #{fetch :releases_path}"
  end
  
  desc "creating shared uploads directory"
  task :create_uploads_dir, :except => {:no_release => true} do
    run "mkdir -p #{fetch :shared_path}/uploads"
  end
  
end

after "deploy:setup", "deploy:create_release_dir", "deploy:create_uploads_dir"

namespace :deploy do

	desc "restrict group from writing to the release directory (some servers require this)"
	task :release_dir_permissions, :except => {:no_release => true} do
		run "chmod -R g-w #{release_path}"
	end

end

namespace :myproject do
    task :create_symlink, :roles => :app do
        run "ln -nfs #{shared_path}/uploads #{release_path}/wp-content/uploads"
    end
end

after "deploy:update_code", "deploy:release_dir_permissions", "myproject:create_symlink"
after "deploy:create_symlink", "deploy:cleanup"