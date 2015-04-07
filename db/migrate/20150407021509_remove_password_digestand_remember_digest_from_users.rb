class RemovePasswordDigestandRememberDigestFromUsers < ActiveRecord::Migration
  def change
   remove_column :users, :password_digest, :string
   remove_column :users, :remember_digest, :string
  end
end
