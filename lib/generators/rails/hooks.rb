require 'rails/generators'
require 'rails/generators/rails/model/model_generator'
require 'rails/generators/rails/resource/resource_generator'
require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module Rails
  module Generators
    class ModelGenerator
      hook_for :decorator, default: true
    end

    class ResourceGenerator
      hook_for :decorator, default: true
    end

    class ScaffoldControllerGenerator
      hook_for :decorator, default: true
    end
  end
end
