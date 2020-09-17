class ChangeEmailToUserIdColumnRiders < ActiveRecord::Migration[6.0]
  def change
    remove_column :riders, :email, :text
    add_column :riders, :user_id, :integer, null: false
    add_index :riders, :user_id
  end
end
