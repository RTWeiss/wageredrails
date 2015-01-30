class AddIdToInitiatingAndReceivingUser < ActiveRecord::Migration
  def change
  	remove_column :bets, :initiating_user 
  	remove_column :bets, :receiving_user
  	add_column :bets, :initiating_user_id, :integer
  	add_index :bets, :initiating_user_id
  	add_column :bets, :receiving_user_id, :integer
  	add_index :bets, :receiving_user_id
  end
end