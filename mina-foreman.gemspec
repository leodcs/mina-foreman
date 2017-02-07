# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/foreman/version'

Gem::Specification.new do |spec|
  spec.name          = 'mina-foreman'
  spec.version       = Mina::Foreman::VERSION
  spec.authors       = ['Stjepan Hadjic']
  spec.email         = ['d4be4st@gmail.com']

  spec.summary       = %q{Mina plugin for foreman}
  spec.description   = %q{Mina plugin for foreman}
  spec.homepage      = 'https://github.com/mina-deploy/mina-foreman'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  
  spec.add_runtime_dependency 'mina', '~> 1.0'
end
