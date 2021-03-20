class AddUniqueIndexToActivityId < ActiveRecord::Migration[6.1]
  def change
    remove_index :rides, :activity_id
    add_index :rides, :activity_id, unique: true
  end
end
