class GamesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create, :edit, :update]
	before_action :admin_user, only: [:new, :create, :edit, :update]

	def index
		@games = Game.paginate(page: params[:page])
		@users = User.all
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
			redirect_to @game
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
	  	params.require(:game).permit(:date, :time, :home_team, :away_team, :home_final_score, :away_final_score, :margin)
	  end

	  def logged_in_user
    	unless logged_in?
    		store_location
    		flash[:danger] = "Please log in."
    		redirect_to login_url
    	end
    end

    def correct_user
    	@user = User.find(params[:id])
    	redirect_to(root_url) unless current_user?(@user)
    end

	  def admin_user
    	redirect_to(root_url) unless current_user.admin?
    end

end
