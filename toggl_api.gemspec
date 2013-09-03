# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toggl_api/version'

Gem::Specification.new do |spec|
  spec.name          = "toggl_api"
  spec.version       = TogglApi::VERSION
  spec.authors       = ["Kang Wen"]
  spec.email         = ["ysorigin@gmail.com"]
  spec.description   = %q{Toggl API Ruby Client}
  spec.summary       = %q{Toggl API Ruby Client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
