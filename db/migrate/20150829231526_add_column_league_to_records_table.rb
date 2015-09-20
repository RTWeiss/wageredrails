class AddColumnLeagueToRecordsTable < ActiveRecord::Migration
  def change
    add_foreign_key :records, :teams, column: :team_id, primary_key: "id"
    add_column :records, :league_id, :integer
    add_foreign_key :records, :leagues
    add_column :games, :season_id, :integer
    add_foreign_key :games, :records, column: :season_id, primary_key: "id"
  end
end
