require 'generator_spec'
require 'generators/rails/decorator/decorator_generator'

RSpec.describe Rails::Generators::DecoratorGenerator, type: :generator do
  destination File.expand_path('../../../../tmp', __FILE__)
  arguments %w(User::Profile)

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'creates user/profile_decorator.rb' do
    assert_file 'app/decorators/user/profile_decorator.rb' do |content|
      expect(content).to include('class User::ProfileDecorator < ApplicationDecorator')
    end
  end
end
