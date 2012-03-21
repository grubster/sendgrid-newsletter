require File.expand_path("../../sendgrid-newsletter", __FILE__)
module Sendgrid
  module Newsletter
    class Newsletter < Base

      def list
        self.class.get '/list.json'
      end

      def add(options={})
        check_required_params options, [:text, :html, :name, :identity, :subject]

        response = self.class.post '/add.json', body: options
        raise APIError.new(response['error']) if response['error']

        response
      end

    end
  end
end
