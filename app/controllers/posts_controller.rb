class PostsController < ApplicationController

  def index
      @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      redirect_to new_post_path , alert: "投稿失敗！140文字までです。"
      
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def edit
  end

  private

  def post_params    
    params.permit(:text,:user_id)
  end
end
