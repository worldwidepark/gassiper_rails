class Sessions::UsersController < Devise::RegistrationsController
  def new
    @user = User.new
    @user_params
  end
  
  def create
    # @user= User.new(user_params)
    # if @user.save
    #   redirect_to posts_path  
    # else
    #   render new_user_path
    # end
  end

  def logout
  end

  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

end
