worker_processes 4
timeout 300
preload_app true
pid 'tmp/pids/unicorn.pid'
working_directory './'
stderr_path 'log/unicorn.error.log'
stdout_path 'log/unicorn.access.log'

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection DB_CONFIG
end
