class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github

    @user = User.find_for_github_oauth(request.env["omniauth.auth"])

    unless @user.deleted_flag
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
      else
        session["devise.github_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    else
      redirect_to new_user_session_path, alert: "退会になられたアカウントです。"
    end
  end
end
