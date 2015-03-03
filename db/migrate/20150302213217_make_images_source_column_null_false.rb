class MakeImagesSourceColumnNullFalse < ActiveRecord::Migration
  def change
    change_column_null :images, :source, false
  end
end
