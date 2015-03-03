class AddNullFalseToUserColumns < ActiveRecord::Migration
  def change
    change_column_null :users, :email, false
    change_column_null :users, :username, false
    change_column_null :users, :name, false
  end
end
