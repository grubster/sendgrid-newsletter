require 'rubygems'
require 'httparty'
require File.expand_path("../sendgrid-newsletter/version", __FILE__)
require File.expand_path("../sendgrid-newsletter/errors", __FILE__)

module Sendgrid
  module Newsletter
    autoload :Config, File.expand_path('../sendgrid-newsletter/config', __FILE__)
    autoload :Base, File.expand_path('../sendgrid-newsletter/base', __FILE__)
    autoload :Newsletter, File.expand_path('../sendgrid-newsletter/newsletter', __FILE__)
    autoload :List, File.expand_path('../sendgrid-newsletter/list', __FILE__)
  end
end
