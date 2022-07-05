class LikesController < ApplicationController

  def create
    like = Like.new(user_id: current_user.id,
                    likable_type: params[:likable_type],
                    likable_id: params[:likable_id])
    if like.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: "'いいね'できませんでした。"
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id,
                        likable_type: params[:likable_type],
                        likable_id: params[:likable_id])
    if like.delete
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: "'いいね'解除に失敗しました。"
    end
  end

  private

  def like_params
    params.require(:like).permit(:likable_type,:likable_id)
  end

end
