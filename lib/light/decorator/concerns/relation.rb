module Light
  module Decorator
    module Concerns
      module Relation
        extend ActiveSupport::Concern

        def decorate(options = {})
          @decorated = true

          override_exec_queries(options)

          self
        end

        def decorated?
          !@decorated.nil?
        end

        private

        def override_exec_queries(options)
          define_singleton_method :exec_queries do
            super()

            @records = @records.map do |record|
              decorate_associations(record, options.reverse_merge(soft: true))
              record.decorate(options)
            end
          end
        end

        def decorate_associations(record, options)
          record.instance_variable_get(:@association_cache).each do |_, association|
            next if association.inversed || association.target.blank?

            if association.target.is_a?(Array)
              targets = association.target.map do |target|
                decorate_associations(target, options)
                target.decorate(options)
              end

              association.instance_variable_set(:@target, targets)
            else
              decorate_associations(association.target, options)
              association.instance_variable_set(:@target, association.target.decorate(options))
            end
          end
        end
      end
    end
  end
end
