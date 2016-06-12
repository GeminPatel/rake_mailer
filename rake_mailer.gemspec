# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake_mailer/version'

Gem::Specification.new do |spec|
  spec.name          = "rake_mailer"
  spec.version       = RakeMailer::VERSION
  spec.authors       = ["Gemin Patel"]
  spec.email         = ["gemin.patel61@gmail.com"]

  spec.summary       = %q{Mail a report by mail about a rake task}
  spec.description   = %q{This can be used by rake task as a simple report generation tool.}
  spec.homepage      = "http://geminpatel.github.io/rake_mailer/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "actionmailer"
  end
