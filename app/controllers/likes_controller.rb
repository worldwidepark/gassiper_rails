class LikesController < ApplicationController

  def create
    if params[:comment_id]
      #commentのいいね
      comment = Comment.find(params[:comment_id])
      comment.likes.create(like: true, user_id: current_user.id)
      redirect_to post_path(comment.post.id)
    else
      #postのいいね
      post = Post.find(params[:post_id])
      post.likes.create(like: true, user_id: current_user.id)
      redirect_to posts_path
    end

  end

  def destroy
    if params[:comment_id]
      #commentのいいね
      comment = Comment.find(params[:comment_id])
      like = comment.likes.find_by(user_id: current_user.id)
      like.delete
      redirect_to post_path(id: comment.post.id)
    else
      #postのいいね
      post = Post.find(params[:post_id])
      like = post.likes.find_by(user_id: current_user.id)
      like.delete
      redirect_to posts_path
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id,:comment_id)
  end

end
