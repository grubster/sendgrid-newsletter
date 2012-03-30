require 'json'
module Sendgrid
  module Newsletter
    class Email < Base
      def add(params={})
        check_required_params(params, [:list, :data])
        raise ArgumentError.new('data params should be an Array or a Hash') unless (params[:data].is_a?(Array) or params[:data].is_a?(Hash))
        all_data = params.delete(:data)
        all_data = [all_data] if all_data.is_a?(Hash)
        raise FieldsRequired.new('data should have :name and :email') if all_data.any? {|d| !d[:email] or !d[:name] }

        list = params[:list]

        all_data = all_data.map {|d| d.to_json }

        _return = {'inserted' => 0}
        while !(data = all_data.shift(1000)).empty? do
          response = self.class.post '/lists/email/add.json', body: "list=#{list}&#{ data.map { |d| "data[]=#{d}" }.join('&') }"
          raise APIError.new(response['error']) if response['error']
          _return['inserted'] += response['inserted'].to_i
        end
        _return
      end
    end
  end
end
