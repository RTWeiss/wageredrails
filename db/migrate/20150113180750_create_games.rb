class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date
      t.string :time
      t.string :home_team
      t.string :away_team
      t.integer :home_final_score, :default => 0
      t.integer :away_final_score, :default => 0
      t.integer :margin

      t.timestamps null: false
    end
  end
end
