class AddLeagueIdColumnToGames < ActiveRecord::Migration
  def change
    add_column :games, :league_id, :integer
    add_foreign_key :games, :leagues, column: :league_id, primary_key: "id"
    game = Game.where(league_id: nil)
    game.each do |game|
      game.update(league_id: game.home_team.league_id)
    end
  end
end
