class Sessions::SessionsController < Devise::SessionsController

  # def new
  #   @user = User.new
  # end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    redirect_to after_sign_in_path_for(resource)
      #   # @user = User.new(user_params)
  #   # user = User.find_by_email(params[:email]) 
  #   # if user && user.valid_password?(params[:password])
  #   #   sign_in(:user, user)
  #   #   session[:user_id] = user.id
  #   #   redirect_to posts_path
  #   # else
  #   #   render 'devise/sessions/new'
  #   # end
    end 

  # def destroy
  #   # @user = User.find_by_email(current_user.id)
  #   # sign_out(@user)
  #   # redirect_to posts_path 
  # end


  # def user_params
  #   params.permit(:email, :password)
  # end
end
