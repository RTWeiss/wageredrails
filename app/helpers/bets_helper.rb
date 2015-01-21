module BetsHelper

	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	def logged_in?
		!current_user.nil?
	end

	def current_user?(user)
		user == current_user
	end

	def store_location
		session[:forwarding_url] = request.url if request.get?
	end

	def display_winning_better(bet)
		current_user_id = current_user.id

		if current_user_id == bet.winning_better && bet.status == "accepted"
			content_tag(:p, "Bet Outcome: You have won this bet!")
	  elsif current_user_id == bet.winning_better && bet.status == "rejected"
	  	content_tag(:p, "Bet Outcome: You would have won this bet!")
	  elsif current_user_id != bet.winning_better && bet.status == "accepted"
	  	content_tag(:p, "Bet outcome: You have lost this bet!")
	  elsif current_user_id != bet.winning_better && bet.status == "rejected"
	  	content_tag(:p, "Bet outcome: You would have lot this bet! Luckily it was rejected")
	  elsif bet.status == "pending"
	  	content_tag(:p, "This bet never received a response!")
	  end
	end

	def display_pick(player, game)
		if player.home 
			content_tag(:div, "#{game.home_team}", class: ["strong"])
	  else
	  	content_tag(:div, "#{game.away_team}", class: ["strong"])
	  end
	end

	def display_handicap(player)
		if player.handicap > 0
			content_tag(:div, "+ #{player.handicap} points", class: ["strong"])
		else
			content_tag(:div, "#{player.handicap} points", class: ["strong"])
		end
	end

	def game_info_display(game)
		if game.margin.nil? 
			content_tag(:div, "#{game.away_team} vs #{game.home_team}", class: ["strong"])
		else
			content_tag(:div, "#{game.home_team} #{game.home_final_score}, #{game.away_team} #{game.away_final_score}", class: ["strong"])
		end
	end

	def display_matchup(game)
		content_tag(:div, "#{game.away_team} vs #{game.home_team}", class: ["strong"])
	end

	def format_date(date)
		date.strftime("%B %e, %Y")
	end

	def display_score(game)
		content_tag(:div, "#{game.away_team} #{game.away_final_score}, #{game.home_team} #{game.home_final_score}", class: ["strong"])
	end

	def home_score(game)
		content_tag(:p, "#{game.home_team}: #{game.home_final_score}")
	end

	def away_score(game)
		content_tag(:p, "#{game.away_team}: #{game.away_final_score}")
	end
end