class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

    	t.belongs_to :user, index: true
    	t.belongs_to :bet, index: true
    	t.string :content
    	t.datetime :created_at

      t.timestamps null: false
    end
  end
end
