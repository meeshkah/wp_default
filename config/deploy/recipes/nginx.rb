namespace :nginx do
  desc "Install latest stable release of nginx"
  task :install, roles: :web do
    run "#{sudo} add-apt-repository -y ppa:nginx/stable"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nginx"
  end
  after "deploy:install", "nginx:install"

  desc "Copy configuration files for NGINX and restart"
  task :config, roles: :web do
    template "conf/nginx.conf", "/tmp/nginx.conf"
    template "conf/mime.types", "/tmp/mime.types"
    run "#{sudo} mv -f /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old; mv -f /tmp/nginx.conf /etc/nginx/nginx.conf"
    run "#{sudo} mv -f /etc/nginx/mime.types /etc/nginx/mime.types.old; mv -f /tmp/mime.types /etc/nginx/mime.types"
  end
  after "nginx:install", "nginx:config"

  desc "Setup nginx configuration for this application"
  task :setup, roles: :web do
    server_template
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-available/#{application}"
    run "#{sudo} ln -nfs /etc/nginx/sites-available/#{application} /etc/nginx/sites-enabled/#{application}"
    restart
  end
  after "deploy:setup", "nginx:setup"

  task :server_template, roles: :web do
    servers = find_servers_for_task(current_task)
    servers.each do |host|
      puts "Make NGINX template for #{host}"
      set :current_host, host
      template "nginx.erb", "/tmp/nginx_conf"
    end
  end

  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command, roles: :web do
      run "#{sudo} service nginx #{command}"
    end
  end
end