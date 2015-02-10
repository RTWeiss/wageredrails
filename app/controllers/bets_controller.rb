class BetsController < ApplicationController
	before_action :logged_in_user, only: [:show, :new, :create, :index]
#	before_action :correct_user, only: [:new, :create, :index]

  def show
    @bet = Bet.find(params[:bet_id])
  end

  def new
    @bet = Bet.new
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
  end

  def create
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
    @bet = current_user.initiated_bets.build(bet_params)
    @bet.receiving_user = @user
    @bet.game = @game

    if @bet.save
     redirect_to root_url
   else
     render 'new'
   end
  end

  def review
    @bets_to_review = current_user.received_bets.where("status = ?", "pending")
  end

  def status
    bet = Bet.find(params[:id])
    bet.update(status_param)

    if bet.save
     redirect_to :back
   else
     redirect_to "/"
   end
  end

  def index
    @initiated_bets = current_user.initiated_bets.all
    @received_bets = current_user.received_bets.all
  end

  private

  def bet_params
    params.require(:bet).permit(:team, :points, :amount)
  end

  def status_param
    params.require(:bet).permit(:status)
  end

  def current_user
    if (user_id = session[:user_id])
     @current_user ||= User.find_by(id: user_id)
   elsif (user_id = cookies.signed[:user_id])
     user = User.find_by(id: user_id)
     if user && user.authenticated?(cookies[:remember_token])
      @current_user = user
    end
  end
  end

  def logged_in_user
    unless logged_in?
     store_location
     flash[:danger] = "Please log in."
     redirect_to login_url
   end
  end

  def correct_user
    @user_present = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user_present)
  end
end