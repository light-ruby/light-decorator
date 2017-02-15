class ApplicationDecorator < Light::Decorator::Base
  # Use `object` or `o` to access object
  # Use `helpers` or `h` to access helpers
  #
  # Example:
  #
  # def created_at
  #   h.content_tag :span, o.created_at.to_s(:long)
  # end
end
