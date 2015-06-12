class TeamsController < ApplicationController
  
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def edit
    @team = Team.find_by_id(params[:id])
    if @team.update_attributes(team_params)
      redirect_to @team
    else
      render 'edit'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :logo_url)
  end
end
