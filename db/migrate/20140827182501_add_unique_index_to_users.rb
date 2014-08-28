class AddUniqueIndexToUsers < ActiveRecord::Migration
  def change
    change_column :users, :session_token, :string, unique: true
    add_index :users, :session_token, unique: true
  end
end
