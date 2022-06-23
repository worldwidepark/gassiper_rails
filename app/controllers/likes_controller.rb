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
      if params[:from_post_show]
        redirect_to post_path(post.id)
      else
        redirect_to posts_path
      end
    end

  end

  def destroy
    if params[:comment_id]
      #commentのいいね
      comment = Comment.find(params[:comment_id])
      like = comment.likes.find_by(user_id: current_user.id)
      like.delete
      if params[:from_user_show]
        redirect_to user_path(params[:user_id])
      else
        redirect_to post_path(id: comment.post.id)
      end
    else
      #postのいいね
      post = Post.find(params[:post_id])
      like = post.likes.find_by(user_id: current_user.id)
      like.delete
      if params[:from_post_show]
        redirect_to post_path(post.id)
      elsif params[:from_user_show]
        redirect_to user_path(params[:user_id])
      else
        redirect_to posts_path
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id,:comment_id,:from_post_show,:from_user_show)
  end

end
