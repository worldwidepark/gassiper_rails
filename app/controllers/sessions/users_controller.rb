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

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    # yield resource if block_given?
    # if resource_updated
    #   set_flash_message_for_update(resource, prev_unconfirmed_email)
    #   bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
    
    redirect_to posts_path
    # else
    #   clean_up_passwords resource
    #   set_minimum_password_length
    #   respond_with resource
    # end
  end

  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

end
