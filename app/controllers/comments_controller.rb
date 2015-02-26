class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create 
    @bet = Bet.find(params[:bet_id])
    @comment = @bet.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment created"
      redirect_to :back
    else
      redirect_to :back
    end
  end


  private 

  def comment_params
    params.require(:comment).permit(:content)
  end
end