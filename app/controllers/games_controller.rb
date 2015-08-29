class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update]
  before_action :admin_user, only: [:new, :create, :edit, :update]

  def index
    @games = Game.where(home_final_score: 0, away_final_score: 0)
    @users = User.all.includes(:image)
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    
    if @game.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find_by_id(params[:id])
    if @game.update_attributes(game_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  private

  def game_params
    params.require(:game).permit(:date, :time, :home_team_id, :away_team_id, :home_final_score, :away_final_score, :margin)
  end
end
