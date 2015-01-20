class PlayersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create] 
#	before_action :correct_user, only: [:new, :create]

	def new
		@player_two = Player.new
		user_id = current_user.id
		@user_bets_pending = Bet.where({ player_2: current_user.id, status: "pending" })
	end

	def create
		bet = Bet.find(params[:id])
		bet_id = bet.id
		player_one = bet.players.first 
		player_one_handicap = player_one.handicap 
		handicap_two = player_one_handicap * -1
		reverse_home_val = !player_one.home 

		player_two = Player.new
		player_two.bet_id = bet_id
		player_two.user_id = current_user.id
		player_two.home = reverse_home_val
		player_two.handicap = handicap_two
		player_two.save!

		bet.update(status_param)

		if player_two.save && bet.save
			redirect_to :back
		else
			redirect_to "/"
		end
	end

	private

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

		def status_param
			params.require(:bet).permit(:status)
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
