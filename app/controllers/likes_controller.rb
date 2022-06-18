class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    if @like.save
      redirect_to posts_path
    else
      render new_post_path
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      redirect_to posts_path, notice: "like削除が成功しました。"
    else
      redirect_to posts_path, alert: "like削除が失敗しました。"
    end
  end

end
