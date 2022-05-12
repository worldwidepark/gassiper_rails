class Sessions::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_parameters
  
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        redirect_to posts_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        redirect_to new_user_registration_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render "devise/registrations/new"
    end
  end

  def show
    @user = User.find(current_user.id)
  end


  def update
    @user = User.find(current_user.id) 
    @user.update(user_params)
    redirect_to posts_path
  end

  private

  def user_params
    params.permit(:name,:introduce)
  end

  def configure_account_update_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduce, :deleted_flag])
  end
 

end
