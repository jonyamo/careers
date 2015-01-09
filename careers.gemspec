# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "careers/version"

Gem::Specification.new do |spec|
  spec.name          = "careers"
  spec.version       = Careers::VERSION
  spec.authors       = ["Jon Yamokoski"]
  spec.email         = ["code@jonyamo.us"]
  spec.summary       = %q{Gem to wrap Stack Overflow Careers feed}
  spec.description   = %q{Gem to wrap Stack Overflow Careers feed}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"

  spec.add_dependency "faraday", "~> 0.9.1"
  spec.add_dependency "typhoeus", "~> 0.6.9"
end
