module TestUnit
  module Generators
    class DecoratorGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_decorator_test
        template 'decorator_test.rb', File.join('test/decorators', class_path, "#{file_name}_decorator_test.rb")
      end
    end
  end
end
