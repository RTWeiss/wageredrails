class Bet < ActiveRecord::Base
  belongs_to :game
  belongs_to :initiating_user, :class_name => "User"
  belongs_to :receiving_user, :class_name => "User"
  belongs_to :team
  has_many :comments
  
  scope :pending, lambda { where(status: "pending") }

  # did the initiating_user bet on the winning team? returns true or false 
  def team_picked_won?
    if team == game.winner
      true
    else
      false
    end
  end

  # did initiators team lose? returns true or false
  def team_picked_lost?
    if team != game.winner
      true
    else
      false
    end
  end

  # returns points scored by initiators team
  def initiators_team_score
    if team_id == game.home_team_id
      game.home_final_score
    else
      game.away_final_score
    end
  end

  # score of initiating users team adjusted by point spread
  def initiator_adjusted_score
    initiators_team_score + points
  end

  # returns score of team bet on by receiver
  def team_score_of_receiver
    if team == game.home_team
      game.away_final_score
    else
      game.home_final_score
    end
  end

  # returns winner of bet or tie
  def winner_of_bet
    if initiator_adjusted_score > team_score_of_receiver
      initiating_user
    elsif initiator_adjusted_score < team_score_of_receiver
      receiving_user
    else
      :tie
    end
  end

# returns the winner of bet (points  number of points given/or taken by initiating user)

#  def winner_of_bet
#    if game.is_tie? && points > 0
#      initiating_user
#    elsif game.is_tie? && points < 0
#      receiving_user
#    elsif game.margin + points == 0
#      :tie
#
#    elsif team_picked_won? && game.margin + points > 0
#      initiating_user
#    elsif team_picked_won? && game.margin + points < 0
#      receiving_user
#    elsif team_picked_lost? && points < 0
#      receiving_user
#    elsif team_picked_lost? && points > game.margin
#      initiating_user
#    end
#  end

  # team receiving user bets on
  def receivers_team
    if team == game.home_team
      game.away_team
    else
      game.home_team
    end
  end

  def receiving_user_points
    points * -1
  end
end
