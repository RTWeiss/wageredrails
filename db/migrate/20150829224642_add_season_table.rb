class AddSeasonTable < ActiveRecord::Migration

  def change
    create_table :records do |t|
      t.integer :year
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.integer :team_id

    end
  end

end
