class Sessions::SessionsController < Devise::SessionsController

  def create
    if deleted_flag
      flash[:session] = "退会になられたアカウントです。"
      redirect_to new_user_session_path
     else  
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      redirect_to after_sign_in_path_for(resource)
    end
  end

private

  def deleted_flag
    @user = User.find_by(email: params[:user][:email])
    @user.deleted_flag
  end
  
end
