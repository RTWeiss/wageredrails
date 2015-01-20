class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|

    	t.integer :player_1
    	t.integer :player_2
    	t.integer :amount
    	t.string :status, :default => "pending"
    	t.belongs_to :game, index: true

      t.timestamps null: false
    end
  end
end
