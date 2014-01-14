def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def sed(file_to_change, script)
  script_file = File.expand_path("../templates/sed/#{script}", __FILE__)
  upload script_file, "/tmp/#{script}"
  run "#{sudo} mv #{file_to_change} #{file_to_change}.old"
  run "#{sudo} sed -f /tmp/#{script} < #{file_to_change}.old > #{file_to_change}"
  run "#{sudo} rm -f /tmp/#{script}"
end

def remote_file_exists?(path)
  results = []
  invoke_command("if [ -e '#{path}' ]; then echo -n 'true'; else echo -n 'false'; fi") do |ch, stream, out|
    results << (out == 'true')
  end
  results.all?
end

def remote_file_read(path)
  str = ""
  invoke_command "cat #{path}" do |ch, stream, out|
    str << out
  end
  str
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} apt-get -y install software-properties-common"
    run "#{sudo} apt-get -y install vim"
    run "#{sudo} apt-get -y install git"
  end
end