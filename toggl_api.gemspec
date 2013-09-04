# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toggl_api/version'

Gem::Specification.new do |spec|
  spec.name          = "toggl_api"
  spec.version       = Toggl::VERSION
  spec.authors       = ["Kang Wen"]
  spec.email         = ["ysorigin@gmail.com"]
  spec.description   = %q{A Ruby interface to the Toggl API https://github.com/toggl/toggl_api_docs}
  spec.summary       = %q{A Ruby interface to the Toggl API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.add_dependency "faraday"
  spec.add_dependency "hashie"
  spec.add_dependency 'multi_json'

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rack-test"
end
