require 'rubygems'
require 'bundler/setup'
require 'vcr'
require 'simplecov'

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path('../fixtures/vcr_cassettes', __FILE__)
  c.hook_into :webmock
end

require File.expand_path('../../lib/sendgrid-newsletter', __FILE__)
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec
end
