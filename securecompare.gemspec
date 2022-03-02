require File.expand_path("../.gemspec", __FILE__)
require File.expand_path("../lib/securecompare/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "securecompare"
  spec.version       = SecureCompare::VERSION
  spec.authors       = ["Samuel Kadolph"]
  spec.email         = ["samuel@kadolph.com"]
  spec.description   = readme.description
  spec.summary       = readme.summary
  spec.homepage      = "https://github.com/samuelkadolph/securecompare"
  spec.license       = "MIT"

  spec.files         = files
  spec.executables   = files.executables
  spec.test_files    = files.tests
  spec.require_paths = files.requires

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
