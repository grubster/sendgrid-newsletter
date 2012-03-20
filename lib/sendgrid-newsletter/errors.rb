module Sendgrid
  module Newsletter
    class Errors < StandardError; end
    class APIError < Errors; end
  end
end
