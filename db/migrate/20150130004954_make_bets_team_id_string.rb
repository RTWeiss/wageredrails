class MakeBetsTeamIdString < ActiveRecord::Migration
  def change
  	remove_column :bets, :team_id
  	add_column :bets, :team, :string
  end
end
