class AddLeagueTable < ActiveRecord::Migration
  def change
    create_table :league do |t|
      t.string :name
    end
  end
end
