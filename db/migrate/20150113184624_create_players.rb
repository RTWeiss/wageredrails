class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|

    	t.belongs_to :bet, index: true
    	t.belongs_to :user, index: true
    	t.float :handicap
    	t.boolean :home

      t.timestamps null: false
    end
  end
end
