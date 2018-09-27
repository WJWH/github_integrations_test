require 'bundler'
require 'json'

Bundler.require

GITHUB_SECRET = 'omg_dat_secret' # So eh yeah, replace this with something more secure in your own thing

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
        `build_container.sh #{commit_sha}`
        'OK'
      else
        puts "push event was not for master branch"
      end
    when "ping"
      puts "Ping event received!"
    end
    "OK"
  end

  helpers do
    def process_push(pull_request)
     puts "It's #{pull_request['title']}"
    end
  end
end
