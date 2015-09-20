class Game < ActiveRecord::Base
  has_many :bets
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'
  belongs_to :league, :class_name => 'League'
  belongs_to :season, :class_name => 'Record'

  # method determines the winning team of game
  def winner
    if home_final_score > away_final_score
      home_team
    elsif away_final_score > home_final_score
      away_team
    else
      :tie
    end
  end

  # method returns true when game outcome is a tie, false when game is not a tie
  def is_tie?
    if margin == 0
      true
    else
      false
    end
  end

  def is_not_tie?
    if margin > 0
      true
    else
      false
    end
  end
end
