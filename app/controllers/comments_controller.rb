class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @snippet = Snippet.find(params[:snippet_id])
    @comment = @snippet.comments.create(comment_params)
    @comment.user_id = current_user.id if current_user
    @comment.name = current_user.name if current_user
    @comment.save!

    redirect_to snippet_path(@snippet)

  end

  def destroy
    @snippet = Snippet.find(params[:snippet_id])
    @comment = @snippet.comments.find(params[:id])
    @comment.destroy
    redirect_to snippet_path(@snippet)
  end

  private

  def comment_params
    params.require(:comment).permit(:response)
  end
end
