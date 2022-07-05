class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.likes.where(likable_type: 'Post')
    @comments = @user.likes.where(likable_type: 'Comment')
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.id), notice: "更新に成功しました。"
    else
      redirect_to user_path(current_user.id), alert: "更新に失敗しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduce, :profile_picture)
  end

end
