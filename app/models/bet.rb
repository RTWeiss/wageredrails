class Bet < ActiveRecord::Base
  belongs_to :game
  has_many :players
  has_many :comments

  def winner_no_spread
    if self.game.winner == :home
      self.players.select { |player| player.home == true}.first
    elsif self.game.winner === :away
      self.players.select { |player| player.home == false }.first
    elsif self.game.winner == :tie
    	'there is no winner'
    end
  end

  def winning_better
    game_winner = self.game.winner
    margin = self.game.margin

    player_a = players.first
    player_b = players.last
    player_b_id = players.last.user_id
    player_b_handicap = players.last.handicap
    player_b_home = players.last.home

    player_a_id = players.first.user_id
    player_a_home = players.first.home 
    player_a_handicap = players.first.handicap

    if game_winner == :home && player_a_home && margin + player_a_handicap > 0
      player_a_id
    elsif game_winner == :home && player_a_home && margin + player_a_handicap < 0
      player_b_id
    elsif game_winner == :home && player_a_home && margin + player_a_handicap == 0
      "bet is push"
    elsif game_winner == :away && player_a_home == false && margin + player_a_handicap > 0
      player_a_id
    elsif game_winner == :away && player_a_home == false && margin + player_a_handicap < 0
      player_b_id 
    elsif game_winner == :away && player_a_home == false && margin + player_a_handicap == 0
      "bet is push"
    elsif game_winner == :home && player_b_home && margin + player_b_handicap > 0
      player_b_id
    elsif game_winner == :home && player_b_home && margin + player_b_handicap < 0
      player_a_id 
    elsif game_winner == :home && player_b_home && margin + player_b_handicap == 0
      "bet is push"
    elsif game_winner == :away && player_b_home == false && margin + player_b_handicap > 0
      player_b_id 
    elsif game_winner == :away && player_b_home == false && margin + player_b_handicap < 0
      player_a_id
    elsif game_winner == :away && player_b_home == false && margin + player_b_handicap == 0
      "bet is push"
    end
  end

  def bet_favorite
    player_a = players.first
    player_a_team = players.first.home
    player_a_handicap = players.first.handicap

    if player_a_handicap < 0 && player_a.home
      self.game.home_team
    elsif player_a_handicap > 0 && player_a.home
      self.game.away_team
    elsif player_a.home == false && player_a_handicap < 0
      self.game.away_team
    elsif player_a.home == false && player_a_handicap > 0
      self.game.home_team
    else
      "Favorite team not defined"
    end
  end
end