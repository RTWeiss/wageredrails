module BetsHelper

  def display_winning_better(bet)
    if current_user == bet.winner_of_bet && bet.status == "accepted"
      content_tag(:p, "Bet Outcome: You have won this bet!")
    elsif current_user == bet.winner_of_bet && bet.status == "rejected"
      content_tag(:p, "Bet Outcome: You would have won this bet!")
    elsif current_user!= bet.winner_of_bet && bet.status == "accepted"
      content_tag(:p, "Bet outcome: You have lost this bet!")
    elsif current_user != bet.winner_of_bet && bet.status == "rejected"
      content_tag(:p, "Bet outcome: You would have lot this bet! Luckily it was rejected")
    elsif bet.status == "pending"
      content_tag(:p, "This bet never received a response!")
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

  def user_avatar_url(user)
    if user.image
      user.image.source.icon40.url
    else
      "https://s3.amazonaws.com/wagerednumerotres/images/fallback/image60_default.jpg"
    end
  end
end