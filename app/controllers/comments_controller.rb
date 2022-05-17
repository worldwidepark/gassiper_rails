class CommentsController < ApplicationController
  def new
    @post= Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(post_params)
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      redirect_to new_comment_path(post_id: params[:post_id]) , alert: "投稿失敗！140文字までです。"
    end
  end

  def post_params    
    params.permit(:text,:user_id,:post_id)
  end

end
