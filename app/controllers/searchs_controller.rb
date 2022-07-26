class SearchsController < ApplicationController
  def show
    @kind = params[:kinds]
    if params[:word].blank?
      redirect_to posts_path, alert: "検索キーワードを入力してください。"
    else
      if @kind == "Posts"
        @searched_posts = Post.where("text LIKE?","%#{params[:word]}%")
      elsif @kind = "Comments"
        @searched_comments = Comment.where("text LIKE?", "%#{params[:word]}%")
      end
    end
  end
end
