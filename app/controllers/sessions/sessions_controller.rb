class Sessions::SessionsController < Devise::SessionsController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    user = User.find_by_email(params[:email]) 
    if user && user.valid_password?(params[:password])
      sign_in(:user, user)
      redirect_to posts_path
    else
      render 'devise/sessions/new'
    end
  end 

  def destroy
    @user = User.find(current_user.id)
    sign_out(@user)
    redirect_to posts_path 
  end


  def user_params
    params.permit(:email, :password)
  end
end
