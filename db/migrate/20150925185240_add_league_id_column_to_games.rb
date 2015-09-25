class AddLeagueIdColumnToGames < ActiveRecord::Migration
  def change
    add_column :games, :league_id, :integer
    add_foreign_key :games, :leagues, column: :league_id, primary_key: "id"
  end
end
