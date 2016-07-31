require 'generator_spec'
require 'generators/light/decorator/install/install_generator'

RSpec.describe Light::Decorator::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../../../tmp', __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'creates application_decorator.rb' do
    assert_file 'app/decorators/application_decorator.rb' do |content|
      expect(content).to include('class ApplicationDecorator < Light::Decorator::Base')
    end
  end
end
