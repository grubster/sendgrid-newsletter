module Sendgrid
  module Newsletter
    class List < Base

      def add(options={})
        check_required_params options, [:list]
        self.class.post '/lists/add.json', body: options
      end

    end
  end
end
