require 'dashing'

configure do
  set :auth_token, '865296646e5f071b08bdb1d79ed951ed'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.

      # Basic HTTP AUTH
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Login to WalterNet")
        throw(:halt, [401, "Not authorized\n"])
      end
    end
    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['dash', 'user']
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
