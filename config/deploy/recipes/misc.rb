namespace :misc do
  
  desc "Change host name in NGINX config file(s)"
  task :set_server_name, roles: :web do
    servers = find_servers_for_task(current_task)
    servers.each do |host|
      run "#{sudo} mv /etc/nginx/sites-available/#{application} /etc/nginx/sites-available/#{application}.old && sed 's|server_name .*;|server_name #{host};|g' < /etc/nginx/sites-available/#{application}.old > /etc/nginx/sites-available/#{application}"
      nginx::restart
    end
  end
end