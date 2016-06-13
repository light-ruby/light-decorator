class PostsController < ApplicationController
  def show
    render locals: { post: post.decorate }
  end

  private

  def post
    return @post if defined?(@post)
    @post = Post.find(params[:id])
  end
end
