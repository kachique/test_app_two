class CommentsController < ApplicationController
  before_action :authenticate_user!
def create
  article = Article.find(params[:comment][:article_id])
  comment = article.comments.build(comment_params)
  comment.user = current_user

  if comment.save
    redirect_to comment.article
  end
end

private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
