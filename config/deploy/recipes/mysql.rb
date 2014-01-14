namespace :mysql do

  desc "Install MYSQL server"
  task :install, roles: :db do
    run "#{sudo} apt-get -y install mysql-server" do |channel, stream, data|
      # prompts for mysql root password (when blue screen appears)
      channel.send_data("#{mysql_password}\n\r") if data =~ /password/
    end
    # save password into a temp file for further use by Capistrano
    run "test -e /tmp/mysql_pass || echo \"#{mysql_password}\" > /tmp/mysql_pass"
    restart
  end
  after "php:install", "mysql:install"

  desc "Setup the database"
  task :setup, roles: :db do
    set :mysql_password, remote_file_exists?("/tmp/mysql_pass") ? remote_file_read("/tmp/mysql_pass") : mysql_entered_password
    run "mysql --user=#{user} --password=#{mysql_password} --execute=\"create database #{application}\""
  end
  after "php:setup", "mysql:setup"

  %w[start stop restart].each do |command|
    desc "#{command} mysql"
    task command, roles: :db do
      run "#{sudo} service mysql #{command}"
    end
  end

end