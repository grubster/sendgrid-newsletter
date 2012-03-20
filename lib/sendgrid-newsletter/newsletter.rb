module Sendgrid
  module Newsletter
    class Newsletter
      include HTTParty
      base_uri 'https://sendgrid.com/api/newsletter'
      format :json

      def initialize
        self.class.default_params api_user: Sendgrid::Newsletter::Config.api_user, api_key: Sendgrid::Newsletter::Config.api_key
      end

      def list
        self.class.get '/list.json', verbose: true
      end
    end
  end
end
