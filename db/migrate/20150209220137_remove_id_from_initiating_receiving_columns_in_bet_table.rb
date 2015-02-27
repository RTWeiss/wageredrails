class RemoveIdFromInitiatingReceivingColumnsInBetTable < ActiveRecord::Migration
  def change
  	remove_column :bets, :initiating_user_id
  	remove_column :bets, :receiving_user_id
  	add_column :bets, :initiating_user, :integer
  	add_column :bets, :receiving_user, :integer
  end
end
