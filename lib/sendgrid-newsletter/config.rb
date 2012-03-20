module Sendgrid
  module Newsletter
    class Config
      class << self
        attr_accessor :api_user, :api_key
      end
    end
  end
end
