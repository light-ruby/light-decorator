$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'light/decorator'

require 'rubygems'
require 'bundler/setup'

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'ffaker'
require 'combustion'
require 'factory_girl'
require 'capybara/rspec'

Combustion.initialize! :all

require 'capybara/rails'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
