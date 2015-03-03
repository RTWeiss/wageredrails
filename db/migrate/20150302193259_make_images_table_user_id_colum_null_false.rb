class MakeImagesTableUserIdColumNullFalse < ActiveRecord::Migration
  def change
    change_column_null :images, :user_id, false
  end
end
