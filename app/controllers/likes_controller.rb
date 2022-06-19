class LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    post.likes.create(like: true, user_id: current_user.id)
    redirect_to posts_path
  end

  def destroy
    @like = Like.find_by(likable_id: params[:post_id], user_id: current_user.id)
    @like.delete
    redirect_to posts_path
  end

  private

  def like_params
    params.require(:like).permit(:user_id,:post_id)
  end

end
