# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/yield/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-yield"
  spec.version       = Guard::YieldVersion::VERSION
  spec.authors       = ["Cezary Baginski"]
  spec.email         = ["cezary@chronomantic.net"]

  spec.summary       = %q{Guard plugin for running custom Ruby code}
  spec.description   = %q{This plugin allows you to run any Ruby code within Guard - without writing your own plugin}
  spec.homepage      = "https://github.com/guard/guard-yield"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('guard-compat', '~> 1.0')

  spec.add_development_dependency "bundler", "~> 1.10"
end
