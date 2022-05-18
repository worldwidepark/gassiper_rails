class PostsController < ApplicationController

  def index
    @posts = Post.all
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
      redirect_to posts_path, notice: "削除に成功しました。"
    else
      redirect_to posts_path, alert: "削除に失敗しました。" 
    end
  end

  def edit
  end

  private

  def post_params    
    params.require(:post).permit(:text,:user_id)
  end
end
