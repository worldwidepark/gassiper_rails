class FollowsController < ApplicationController
  def create
    user= User.find(current_user.id)
    follow = user.follows.new(followed_id: params[:want_follow_user_id])
    if follow.save
      redirect_to user_path(params[:want_follow_user_id]), notice: "フォローしました。"
    end
  end

  def destroy
    user= User.find(current_user.id)
    follow_info = user.follows.find_by(followed_id: params[:want_unfollow_user_id])
    follow_info.delete
    redirect_to user_path(params[:want_unfollow_user_id]), alert: "フォローをやめました。"
  end



end
