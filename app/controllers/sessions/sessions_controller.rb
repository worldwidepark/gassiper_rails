class Sessions::SessionsController < Devise::SessionsController

  def create
    if deleted_flag
      redirect_to new_user_session_path, alert: "退会になられたアカウントです。" 
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
    @user ? @user.deleted_flag : false
  end
  
end
