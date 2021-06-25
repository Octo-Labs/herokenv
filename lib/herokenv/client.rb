require 'platform-api'

module Herokenv
  class Client
    attr_accessor :oauth_token
    attr_accessor :app
    def initialize(oauth_token:, app:)
      @oauth_token = oauth_token
      @app = app
    end

    def populate_env_from_app
      configs = heroku.config_var.info_for_app(app)
      configs.each_pair do |var, value|
        ENV[var] = value
      end
    end

    def heroku
      @heroku ||= PlatformAPI.connect_oauth(oauth_token)
    end
  end
end
