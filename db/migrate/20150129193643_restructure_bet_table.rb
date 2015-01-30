class RestructureBetTable < ActiveRecord::Migration
  def change
  	remove_column :bets, :player_1
  	remove_column :bets, :player_2
  	add_column :bets, :initiating_user, :integer
  	add_index :bets, :initiating_user
  	add_column :bets, :receiving_user, :integer
  	add_index :bets, :receiving_user
  	add_column :bets, :team_id, :integer
  	add_column :bets, :points, :float
  end
end
