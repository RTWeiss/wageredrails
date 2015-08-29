class AddForeignKeysToGame < ActiveRecord::Migration
  def change
    remove_column :games, :home_team
    remove_column :games, :away_team
    add_column :games, :away_team_id, :integer
    add_column :games, :home_team_id, :integer
    add_foreign_key :games, :teams, column: :away_team_id, primary_key: "id"
    add_foreign_key :games, :teams, column: :home_team_id, primary_key: "id"
  end
end
