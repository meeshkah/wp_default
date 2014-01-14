namespace :php do 
	desc "Install latest stable php5 release with sugar"
	task :install, roles: :web do
		run "#{sudo} add-apt-repository -y ppa:ondrej/php5"
		run "#{sudo} apt-get -y update"
		run "#{sudo} apt-get -y install php5-cli php5-common php5-mysql 
				 php5-xmlrpc php5-cgi php5-curl php5-gd 
				 php5-fpm php-pear php5-dev php5-imap php5-mcrypt"
	end
	after "nginx:config", "php:install"

	desc "Setup PHP"
	task :setup, roles: :web do
		sed "/etc/php5/fpm/php.ini", 				 "php_settings"
		sed "/etc/php5/fpm/php-fpm.conf", 	 "php-fpm_settings"
		sed "/etc/php5/fpm/pool.d/www.conf", "fpm-www.conf_settings"
	end
	after "nginx:setup", "php:setup"

	namespace :opcache do

		desc "Setup OPCache"
		task :setup, roles: :web do
			sed "/etc/php5/fpm/php.ini", "php-opcache_settings"
			nginx::restart
		end
		after "php:setup", "php:opcache:setup"

	end

end