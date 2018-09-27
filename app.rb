require 'bundler'
require 'json'

Bundler.require

class WebhookTester < Sinatra::Base
  get '/' do
    'biep'
  end
  
  post '/event_handler' do
    @payload = JSON.parse(params[:payload])
  
    case request.env['HTTP_X_GITHUB_EVENT']
    when "push"
      if @payload['ref'] == 'refs/heads/master'
        puts "received commit for master"
        commit_sha = @payload['head_commit']['id']
        puts "SHA of latest commit: #{commit_sha}"
        Process.spawn("./build_container.sh #{commit_sha}")
        'OK'
      else
        puts "push event was not for master branch"
      end
    when "ping"
      puts "Ping event received!"
    end
    "OK"
  end
end
