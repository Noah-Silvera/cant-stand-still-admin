class AddUniqueIndexToUserId < ActiveRecord::Migration[6.1]
  def change
    remove_index :riders, :user_id
    add_index :riders, :user_id, unique: true
  end
end
