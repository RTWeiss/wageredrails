class AddNullFalseToBetsTable < ActiveRecord::Migration
  def change
    change_column_null :bets, :amount, false 
    change_column_null :bets, :game_id, false
    change_column_null :bets, :points, false
    change_column_null :bets, :team, false 
    change_column_null :bets, :initiating_user_id, false 
    change_column_null :bets, :receiving_user_id, false
  end
end
