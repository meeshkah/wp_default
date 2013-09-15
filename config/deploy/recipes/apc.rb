namespace :apc do
	desc "Install APC for PHP5"
	task :install, roles: :web do
		run "#{sudo} apt-get -y install libpcre3-dev"
		run "#{sudo} pecl install apc"
		run "#{sudo} cat "
	end

	desc "Enable APC"
	task :enable, roles: :web do
		run "#{sudo} sed ..."
	end

	desc "Disable APC"
	task :disable, roles: :web do
		run "#{sudo} sed ..."
	end

	desc "Clear APC cache"
	task :flush, roles: :web do
		run "#{sudo} php -r \"apc_clear_cache();\""
	end
end