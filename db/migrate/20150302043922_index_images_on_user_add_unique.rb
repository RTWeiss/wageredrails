class IndexImagesOnUserAddUnique < ActiveRecord::Migration
  def change
    remove_index :images, :user_id
    add_index :images, :user_id, unique: true
  end
end
