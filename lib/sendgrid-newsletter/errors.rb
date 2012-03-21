module Sendgrid
  module Newsletter
    class Errors < StandardError; end

    class APIError < Errors; end
    class FieldsRequired < Errors; end
  end
end
