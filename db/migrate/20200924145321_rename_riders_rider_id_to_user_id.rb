class RenameRidersRiderIdToUserId < ActiveRecord::Migration[6.0]
  def change
    rename_index :rides, :index_rider_id, :index_user_id
    rename_column :rides, :rider_id, :user_id
  end
end
