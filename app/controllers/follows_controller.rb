class FollowsController < ApplicationController
  def create
    follow = current_user.follows.new(followed_id: params[:want_follow_user_id])
    if follow.save
      redirect_to user_path(params[:want_follow_user_id]), notice: "フォローしました。"
    else
      redirect_to user_path(params[:want_follow_user_id]), alert: "フォローが失敗しました。"
    end
  end

  def destroy
    user= User.find(current_user.id)
    follow_info = user.follows.find_by(followed_id: params[:want_unfollow_user_id])
    if follow_info.delete
      redirect_to user_path(params[:want_unfollow_user_id]), notice: "フォローを解除しました。"
    else
      redirect_to user_path(params[:want_follow_user_id]), alert: "フォローの解除が失敗しました。"
    end
  end

end
