namespace :php do 
	desc "Install latest stable php5 release with sugar"
	task :install, roles: :web do
		run "#{sudo} add-apt-repository -y ppa:ondrej/php5"
		run "#{sudo} apt-get -y update"
		run "#{sudo} apt-get -y install php5-common php5-mysql 
				 php5-xmlrpc php5-cgi php5-curl php5-gd php5-cli 
				 php5-fpm php-pear php5-dev php5-imap php5-mcrypt"
	end
	after "nginx:install", "php:install"

	desc "Setup PHP"
	task :setup, roles: :web do
		
	end

end