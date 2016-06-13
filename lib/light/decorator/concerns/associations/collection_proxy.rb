module Light
  module Decorator
    module Concerns
      module Associations
        module CollectionProxy
          extend ActiveSupport::Concern

          def decorate(options = {})
            @decorated = true

            override_scope(options)
            override_load_target(options)

            self
          end

          def decorated?
            !@decorated.nil?
          end

          private

          def override_scope(options)
            @association.define_singleton_method :scope do |opts = {}|
              super(opts).decorate(options)
            end
          end

          def override_load_target(options)
            @association.define_singleton_method :load_target do
              super().map { |target| target.decorate(options) }
            end
          end
        end
      end
    end
  end
end
