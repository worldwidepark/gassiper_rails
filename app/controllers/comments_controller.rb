class CommentsController < ApplicationController
  def new
    @post= Post.find(params[:post_id])
    @comment= @post.comments.new()
  end

  def create
    @comment = Comment.new(post_params)
    if @comment.save
      redirect_to post_path(@comment.post_id), notice: "コメントが作成されました。"
    else
      render new_comment_path(post_id: @comment.post_id)
    end
  end

  def post_params    
    params.require(:comment).permit(:text,:user_id,:post_id)
  end

end
