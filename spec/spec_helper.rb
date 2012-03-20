require 'minitest/autorun'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path('../fixtures/vcr_cassettes', __FILE__)
  c.hook_into :webmock
end
