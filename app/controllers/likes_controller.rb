class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    Like.create(post_id: @post.id, user_id: current_user.id) if user_signed_in?
    render json: { new_like_count: @post.likes.count }
  end
end
