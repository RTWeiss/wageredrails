class Bet < ActiveRecord::Base
  belongs_to :game
  belongs_to :initiating_user, :class_name => "User"
  belongs_to :receiving_user, :class_name => "User"
  has_many :comments


  # returns the winner of bet
  def winner_of_bet
    victorious_team = self.game.victorious_team
    margin = self.game.margin

    if victorious_team == team && margin + points > 0
      initiating_user
    elsif victorious_team == team && margin + points < 0
      receiving_user
    elsif victorious_team == team && margin + points == 0
      :tie
    elsif victorious_team != team  && margin + points < 0
      initiating_user
    elsif victorious_team != team && margin + points > 0
      receiving_user
    elsif victorious_team != team && margin + points == 0
      :tie
    end
  end
  
end