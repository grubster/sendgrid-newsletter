# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sendgrid-newsletter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nelson Haraguchi"]
  gem.email         = ["nelsonmhjr@gmail.com"]
  gem.description   = %q{Sendgrid Newsletter API in Ruby}
  gem.summary       = %q{Send a Newsletter with Sendgrid}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "sendgrid-newsletter"
  gem.require_paths = ["lib"]
  gem.version       = Sendgrid::Newsletter::VERSION
end
