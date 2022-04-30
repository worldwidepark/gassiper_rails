class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:email]) 
    if user && user.valid_password?(params[:password])
      sign_in(:user, user)
      session[:user_id] = user.id
      redirect_to posts_path
    else
      sign_out(user)
      render new_session_path
    end
  end
  
  def destroy
    @user = User.find_by_email(session[:user_id])
    sign_out(@user)
    redirect_to posts_path 
  end


  def user_params
    params.permit(:email)
  end

end
