class AddForeignKeysToGame < ActiveRecord::Migration
  def change
    remove_column :games, :home_team
    remove_column :games, :away_team
    add_reference :games, :home_team
    add_reference :games, :away_team
    add_foreign_key :games, :home_team
    add_foreign_key :games, :away_team
  end
end
