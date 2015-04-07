# controller for comments

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @bet = Bet.find(params[:id])
    @comment = @bet.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment created"
      redirect_to :back
    else
      flash[:notice] = "Comment failed to save!"
      redirect_to :back
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
