class UsersController < ApplicationController
  before_action :user_find
  def show
    @user = User.find(params[:id])
  end

  def update
    if !@user.update(user_params)
      redirect_to user_path(current_user.id), alert: "更新に失敗しました。" 
    else
      redirect_to user_path(current_user.id), notice: "更新が完了しました。"
    end
  end

  private

  def user_find
    if current_user
      @user = User.find(current_user.id)    
    end
  end
  def user_params
    params.require(:user).permit(:name, :introduce, :profile_picture)
  end

end
