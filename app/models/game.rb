class Game < ActiveRecord::Base
  has_many :bets

  validates :home_team, presence: true
  validates :away_team, presence: true
  
  # winning team
  def victorious_team
    if home_final_score > away_final_score
      home_team
    elsif away_score > home_score
      away_team
    else
      :tie
    end
  end	
end
