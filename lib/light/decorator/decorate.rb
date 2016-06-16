module Light
  module Decorator
    class Decorate
      # @return original object
      attr_reader :object

      # Decorate the object
      #
      # @param [Object] object for decoration
      # @param [Hash] options
      #
      # @return [Object] decorated object
      def initialize(object, options = {})
        @object = object
        @options = options

        delegate_methods
        decorate_associations
      end

      # Check current ActiveRecord::Model is decorated or not
      #
      # @return [Bool]
      def decorated?
        true
      end

      # Current view scope
      #
      # @return [ActionView::Base]
      def helpers
        return @helpers if defined?(@helpers)
        @helpers = Light::Decorator::ViewContext.current
      end

      def ==(other)
        super || object == other
      end

      def eql?(other)
        super || object.eql?(other)
      end

      class << self
        alias decorate new
      end

      alias o object
      alias h helpers

      private

      def delegate_methods
        # It's more faster than using Forwardable
        (object.public_methods - methods + Light::Decorator::FORCE_DELEGATE).each do |method|
          define_singleton_method method do |*args, &block|
            object.__send__(method, *args, &block)
          end
        end
      end

      def decorate_associations
        object.class.reflect_on_all_associations.map(&:name).each do |reflection_name|
          define_singleton_method reflection_name do
            object.public_send(reflection_name).decorate(@options.reverse_merge(soft: true))
          end
        end
      end
    end
  end
end
