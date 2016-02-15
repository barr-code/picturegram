class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if user_signed_in?
      existing_like = @post.likes.where(user_id: current_user.id).first
      if !existing_like
        Like.create(post_id: @post.id, user_id: current_user.id)
        liked = true
      end
    end
    render json: { new_like_count: @post.likes.count, liked: liked }
  end
end
