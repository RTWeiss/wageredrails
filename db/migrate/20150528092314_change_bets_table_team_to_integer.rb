class ChangeBetsTableTeamToInteger < ActiveRecord::Migration
  def change
    remove_column :bets, :team, :string
    add_reference :bets, :team, index: true
  end
end
