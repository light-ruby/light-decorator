module Light
  module Decorator
    class Railtie < Rails::Railtie
      config.after_initialize do |app|
        # Eager loading of Decorators classes
        app.config.paths.add 'app/decorators', eager_load: true
      end

      initializer 'light.decorator.inject_orm' do
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.send(:include, ::Light::Decorator::Concerns::Base)
          ActiveRecord::Relation.send(:include, ::Light::Decorator::Concerns::Relation)
          ActiveRecord::Associations::CollectionProxy.send(
            :include, ::Light::Decorator::Concerns::Associations::CollectionProxy
          )
        end
      end

      initializer 'light.decorator.load_view_context' do
        [:action_controller, :action_mailer].each do |action_module|
          ActiveSupport.on_load action_module do
            include ::Light::Decorator::ViewContext
          end
        end
      end
    end
  end
end
