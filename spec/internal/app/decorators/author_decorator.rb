class AuthorDecorator < ApplicationDecorator
  def first_name
    object.first_name * 3
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
