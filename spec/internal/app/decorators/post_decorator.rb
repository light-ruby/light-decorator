class PostDecorator < ApplicationDecorator
  def title_h1
    helpers.content_tag :h1, object.title
  end

  def title_h1_h
    h.content_tag :h1, object.title
  end

  def title_o
    o.title
  end
end
