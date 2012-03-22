require File.expand_path("../../sendgrid-newsletter", __FILE__)
module Sendgrid
  module Newsletter
    class Schedule < Base

      def add(options={})
        check_required_params options, [:name]
        response = self.class.post '/schedule/add.json', body: options
        raise APIError.new(response['error']) if response['error']
        response
      end

      def delete(options={})
        check_required_params options, [:name]
        response = self.class.post '/schedule/delete.json', body: options
        raise APIError.new(response['error']) if response['error']
        response
      end

    end
  end
end
