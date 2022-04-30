class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    user = User.find_by_email(params[:email]) 
    if user && user.valid_password?(params[:password])
      sign_in(:user, user)
      session[:user_id] = user.id
      redirect_to posts_path
    else
      render new_session_path
    end
  end
  
  def destroy
    @user = User.find_by_email(current_user.id)
    sign_out(@user)
    redirect_to posts_path 
  end


  def user_params
    params.permit(:email, :password)
  end

end
