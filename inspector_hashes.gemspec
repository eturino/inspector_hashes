# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inspector_hashes/version'

Gem::Specification.new do |spec|
  spec.name = 'inspector_hashes'
  spec.version = InspectorHashes::VERSION
  spec.authors = ['Eduardo Turiño']
  spec.email = ['eturino@eturino.com']

  spec.required_ruby_version = '>= 2.1'

  spec.summary = <<-TXT
  InspectorHashes helps finding hidden differences in hashes and arrays, included nested, also spotting missing keys or indices
TXT
  spec.description = <<-TXT
  InspectorHashes helps finding hidden differences in hashes and arrays, included nested, also spotting missing keys or indices. Specially useful for spotting differences between expected json response and actual json response on requests specs
TXT
  spec.homepage = 'https://github.com/eturino/inspector_hashes'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
