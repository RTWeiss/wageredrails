class Player < ActiveRecord::Base
  belongs_to :bet
  belongs_to :user

  validates :handicap, presence: true

  def team_picked
  	if self.home == true
  		self.bet.game.home_team
  	elsif self.home == false
  		self.bet.game.away_team
  	end
  end
end