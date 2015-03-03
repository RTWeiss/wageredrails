class AddNullFalseToCommentsColumns < ActiveRecord::Migration
  def change
    change_column_null :comments, :user_id, false
    change_column_null :comments, :bet_id, false
    change_column_null :comments, :content, false
  end
end
