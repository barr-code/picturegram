class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    search = params[:search] if params[:search] && !params[:search].blank?
    if search
      @posts = Post.filter_by_hashtag(search)
    else
      @posts = Post.order("id DESC")
    end
    respond_to do |format|
      format.json { render json: {posts: @posts.distinct} }
      format.html { render 'index'}
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.json { render json: {
        post: @post, comments: @post.comments, likes: @post.likes}
      }
      format.html { render 'index' }
    end
  end

  def edit
  end

  def create
    if current_user
      @post = Post.new(post_params)
      @post.user_id = current_user.id
    end
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
      else
        format.html { render :new, notice: 'There was a problem.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Success!' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Poof! That post is history.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params[:post].permit(:image, :message)
    end
end
