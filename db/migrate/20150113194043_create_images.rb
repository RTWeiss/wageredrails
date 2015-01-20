class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|

    	t.string :source
    	t.belongs_to :user, index: true
    	t.datetime :created_at

      t.timestamps null: false
    end
  end
end
