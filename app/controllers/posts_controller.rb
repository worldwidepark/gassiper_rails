class PostsController < ApplicationController
  def index
  # # @posts = User.all
  
  if user_signed_in?
    @pa = "go"
  else
    @pa = "back"
  end

  
  end

  def create
  end

  def edit
  end
end
