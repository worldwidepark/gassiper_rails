class FollowsController < ApplicationController
  def create
    user= User.find(current_user.id)
    follow = user.follows.create(followed_id: params[:want_follow_user_id])
    redirect_to user_path(params[:want_follow_user_id])
  end

  def destroy
    user= User.find(current_user.id)
    unfollow = user.follows.destroy(followed_id: params[:want_follow_user_id])
    redirect_to user_path(params[:want_follow_user_id])
  end



end
