module Light
  module Decorator
    class Error < StandardError; end
    class NotFound < Light::Decorator::Error; end
  end
end
