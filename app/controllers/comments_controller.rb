class CommentsController < ApplicationController
  def create
    @doubt = Doubt.find(params[:doubt_id])
    @comment = @doubt.comments.create(comment_params)
    redirect_to root_path
  end

  def destroy
    @doubt = Doubt.find(params[:doubt_id])
    @comment = @doubt.comments.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
