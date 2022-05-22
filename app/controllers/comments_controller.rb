class CommentsController < ApplicationController
  def new
    @post= Post.find(params[:id])
    @comment= @post.comments.new()
  end

  def create
    @comment = Comment.new(post_params)
    @post= @comment.post
    if @comment.save
      redirect_to post_path(@comment.post_id), notice: "コメントが作成されました。"
    else
      render 'comments/new.html.slim'
    end
  end

  private
  
  def post_params    
    params.require(:comment).permit(:text,:user_id,:post_id)
  end

end
