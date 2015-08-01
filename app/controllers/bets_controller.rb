class BetsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :index]
#  before_action :correct_user, only: [:new, :create, :index]

  def show
    @bet = Bet.find(params[:id])
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
    @bets_to_review = current_user.received_bets.pending.includes(:initiating_user, :game, :team, :receiving_user)
  end

  def update
    bet = Bet.find(params[:id])
    bet.update(status_param)

    if bet.save
      redirect_to :back
    else
      redirect_to "/"
    end
  end

  def index
    @initiated_bets = current_user.initiated_bets.includes(:team, :receiving_user, :initiating_user, game: [:away_team, :home_team])
    @received_bets = current_user.received_bets.includes(:team, :receiving_user, :initiating_user, game: [:away_team, :home_team])
  end

  private

  def bet_params
    params.require(:bet).permit(:team_id, :points, :amount)
  end

  def status_param
    params.require(:bet).permit(:status)
  end
end
