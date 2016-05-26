class CommentsController < ApplicationController
  def create
    user_id = params[:user_id] if !params[:user_id].blank?
    if user_id
      post = Post.find(params[:post_id])
      comment = post.comments.create(content: params[:content], user_id: user_id)
      render json: { content: comment.content, username: comment.user.username, comment_id: comment.id }
    else
      render json: { error: "Could not create comment" }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
    render json: nil, status: :ok
  end
end
