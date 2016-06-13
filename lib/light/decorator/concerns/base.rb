module Light
  module Decorator
    module Concerns
      module Base
        extend ActiveSupport::Concern

        def decorate(options = {})
          return self if decorated?

          klass = decorator_class(options)
          klass.decorate(self, options)
        rescue Light::Decorator::NotFound => e
          raise e unless options[:soft]
          self
        end

        def decorated?
          false
        end

        def ==(other)
          super || other.respond_to?(:object) && self == other.object
        end

        def eql?(other)
          super || other.respond_to?(:object) && eql?(other.object)
        end

        private

        def decorator_class(options)
          with = options.delete(:with)
          return "#{self.class}Decorator".constantize unless with

          with = with.constantize unless with.is_a?(Class)
          with
        rescue NameError
          raise Light::Decorator::NotFound, "Decorator#{with ? " #{with}" : ''} for #{self.class} not found"
        end

        module ClassMethods
          def decorate(options = {})
            all.decorate(options)
          end

          def find_and_decorate(id, options = {})
            find(id).decorate(options)
          end
        end
      end
    end
  end
end
