class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user= User.new(user_params)
    
    if @user.save
      redirect_to posts_path  
    else
      @error = @user.errors.full_messages
      render new_user_path
    end
  end

  def logout
  end

  def show
  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end

end
