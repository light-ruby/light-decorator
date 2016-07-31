module Light
  module Decorator
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_application_decorator
          template 'application_decorator.rb', File.join('app/decorators', 'application_decorator.rb')
        end
      end
    end
  end
end
