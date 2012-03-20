require File.expand_path("../sendgrid-newsletter/version", __FILE__)
require File.expand_path("../sendgrid-newsletter/errors", __FILE__)

require 'httparty'

module Sendgrid
  module Newsletter
    autoload :Config, File.expand_path('../sendgrid-newsletter/config', __FILE__)
    autoload :Newsletter, File.expand_path('../sendgrid-newsletter/newsletter', __FILE__)
  end
end
