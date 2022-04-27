class SessionsController < ApplicationController

  def create
    # if @user = User.find(email: 1)
    # else
    # end
    @email = params[:email]
    @password = params[:password]
  # redirect_to new_user_path
  end
end
