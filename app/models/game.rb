class Game < ActiveRecord::Base
  has_many :bets

  validates :home_team, presence: true
  validates :away_team, presence: true

  def winner
    home_score = home_final_score
    away_score = away_final_score

    if home_score > away_score
      :home
    elsif away_score > home_score
      :away
    else
      :tie
    end
  end	
end
