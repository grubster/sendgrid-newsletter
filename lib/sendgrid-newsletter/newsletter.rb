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
        self.class.get '/list.json'
      end

      def add(options={})
        check_required_params options, [:text, :html, :name, :identity, :subject]

        response = self.class.post '/add.json', body: options
        raise APIError.new(response['error']) if response['error']

        response
      end

      private
      def check_required_params(options, required_keys)
        (required_keys - options.keys).each do |k|
          raise ArgumentError.new("You must pass :#{k} argument") if options[k].nil? || options[k] == ''
        end
      end
    end
  end
end
