# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'light/decorator/version'

Gem::Specification.new do |spec|
  spec.name          = 'light-decorator'
  spec.version       = Light::Decorator::VERSION
  spec.authors       = ['Andrew Emelianenko']
  spec.email         = ['emelianenko.web@gmail.com']

  spec.summary       = 'Light pattern Decorator for Rails'
  spec.description   = 'Light pattern Decorator for Rails from Light Ruby'
  spec.homepage      = 'https://github.com/light-ruby/light-decorator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 4.0.0'
  spec.add_dependency 'request_store', '>= 1.0.0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.11'
  spec.add_development_dependency 'combustion', '~> 0.5.4'
  spec.add_development_dependency 'appraisal', '~> 2.1'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.11.2'
  spec.add_development_dependency 'capybara', '~> 2.7.0'
  spec.add_development_dependency 'factory_girl', '~> 4.0'
  spec.add_development_dependency 'ffaker', '~> 2.2.0'
  spec.add_development_dependency 'generator_spec', '~> 0.9.3'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
