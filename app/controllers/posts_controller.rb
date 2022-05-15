class PostsController < ApplicationController
  def index
    @posts = Post.all
    @users = User.all
  end
  
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to posts_path
    else
      render new_post_path 
    end
    

  end

  def edit
  end

  private

  def post_params    
    params.permit(:text,:user_id)
  end
end
