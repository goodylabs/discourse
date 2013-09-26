require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Hosm < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "hosm"
      # option :authorize_url, "/"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {:site => "http://localhost:3002/"}

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['id'] }

      info do
        {
          :email => raw_info['email']
        }
      end

      extra do
        {
          :first_name => raw_info['extra']['first_name'],
          :last_name  => raw_info['extra']['last_name']
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/oauth/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
