class PostsController < ApplicationController

  def index
    if current_user
      @posts = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
      @posts_unfollowed = Post.where.not(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def new
    @post = current_user.posts.new()
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render new_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: "削除が成功しました。"
    else
      redirect_to posts_path, alert: "削除が失敗しました。"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:text,:user_id)
  end
end
