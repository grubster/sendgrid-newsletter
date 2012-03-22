require File.expand_path("../../sendgrid-newsletter", __FILE__)
module Sendgrid
  module Newsletter
    class Recipient < Base

      def add(options={})
        check_required_params options, [:name, :list]
        response = self.class.post '/recipients/add.json', body: options
        raise APIError.new(response['error']) if response['error']
        response
      end

      def delete(options={})
        check_required_params options, [:name, :list]
        response = self.class.post '/recipients/delete.json', body: options
        raise APIError.new(response['error']) if response['error']
        response
      end

    end
  end
end
