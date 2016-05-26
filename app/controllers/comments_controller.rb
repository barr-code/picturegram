class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(content: params[:content], user_id: params[:user_id])
    render json: { content: @comment.content, username: @comment.user.username }
  end
end
