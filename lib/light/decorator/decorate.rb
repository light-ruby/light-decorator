module Light
  module Decorator
    class Decorate
      extend Forwardable

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

      class << self
        alias decorate new
      end

      def decorated?
        true
      end

      def helpers
        return @helpers if defined?(@helpers)
        @helpers = Light::Decorator::ViewContext.current
      end

      alias o object
      alias h helpers

      def ==(other)
        super || object == other
      end

      def eql?(other)
        super || object.eql?(other)
      end

      private

      def delegate_methods
        methods = object.methods - Light::Decorator::NOT_DELEGATABLE_METHODS
        self.class.def_delegators :@object, *methods
      end

      def decorate_associations
        # TODO: Remove it before production
        # meta = class << self; self; end
        # object._reflections.keys.each do |reflection_name|
        #   meta.send(:define_method, "#{reflection_name}_a") do
        #     [4,3,2,1]
        #   end
        # end

        object.class.reflect_on_all_associations.map(&:name).each do |reflection_name|
          define_singleton_method reflection_name do
            object.public_send(reflection_name).decorate(@options.reverse_merge(soft: true))
          end
        end
      end
    end
  end
end
