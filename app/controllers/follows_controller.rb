class FollowsController < ApplicationController
  def create
    if current_user.follow(params[:want_follow_user_id])
      redirect_to user_path(params[:want_follow_user_id]), notice: "フォローしました。"
    else
      redirect_to user_path(params[:want_follow_user_id]), alert: "フォローが失敗しました。"
    end
  end

  def destroy
    if current_user.unfollow(params[:want_unfollow_user_id])
      redirect_to user_path(params[:want_unfollow_user_id]), notice: "フォローを解除しました。"
    else
      redirect_to user_path(params[:want_follow_user_id]), alert: "フォローの解除が失敗しました。"
    end
  end

end
