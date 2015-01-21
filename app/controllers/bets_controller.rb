class BetsController < ApplicationController
	before_action :logged_in_user, only: [:show, :new, :create, :index]
	before_action :correct_user, only: [:new, :create, :index]

	def show
		@bet = Bet.find(params[:bet_id])
		@comment = Comment.new
	end

	def new
		@bet = Bet.new
		@player = Player.new
		@user = User.find(params[:user_id])
		@game = Game.find(params[:game_id])
	end

	def create
		@user = User.find(params[:id])
		@game = Game.find(params[:game_id])
		@bet = Bet.new(bet_params)
		@bet.player_1 = current_user.id
		@bet.player_2 = @user.id 

		@bet.game_id = @game.id
		@bet.save! 

		@player = Player.new(player_params)
		@player.bet_id = @bet.id
		@player.user_id = current_user.id

    if @player.save
    	redirect_to "/"
    else
    	render 'new'
    end
	end

	def index
		@player_1_bets = Bet.where(player_1: current_user.id)
		@player_2_bets = Bet.where(player_2: current_user.id, status: "accepted")
  end
  
  private

    def bet_params
    	params.require(:bet).permit(:amount)
    end

    def player_params
    	params.require(:player).permit(:home, :handicap)
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
    	@user = User.find(params[:id])
    	redirect_to(root_url) unless current_user?(@user)
    end

end
