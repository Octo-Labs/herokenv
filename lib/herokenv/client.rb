require 'platform-api'

module Herokenv
  class Client
    attr_accessor :oauth_token
    attr_accessor :app
    def initialize(oauth_token:, app:)
      @oauth_token = oauth_token
      @app = app
    end

    def populate_env_from_app(only: nil, except: nil)
      configs = heroku.config_var.info_for_app(app)
      configs.each_pair do |var, value|
        if except && except.include?(var)
          next
        end
        if only && !only.include?(var)
          next
        end
        ENV[var] = value
      end
    end

    def heroku
      @heroku ||= PlatformAPI.connect_oauth(oauth_token)
    end
  end
end
