require File.expand_path("../sendgrid-newsletter/version", __FILE__)

module Sendgrid
  module Newsletter
    autoload :Config, File.expand_path('../sendgrid-newsletter/config', __FILE__)
  end
end
