require 'spec'
require 'rubygems'
require 'redgreen'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'lib/gcal_fetcher'

Spec::Runner.configure do |config| 

end

def start_sinatra
  pid = Process.fork do
    exec "ruby #{File.join(File.dirname(__FILE__), '..','servers', 'server.rb')} >> 'log.txt'"
  end
  sleep 2
  pid
end

def stop_sinatra(pid)
  Process.kill 'HUP', pid
end
