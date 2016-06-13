module Light
  module Decorator
    module ViewContext
      def view_context
        super.tap do |context|
          RequestStore[:light_decorator_context] = context
        end
      end

      def self.current
        RequestStore[:light_decorator_context] || fake_context
      end

      # @private
      def self.fake_context
        ActionView::Base.new
      end
    end
  end
end
