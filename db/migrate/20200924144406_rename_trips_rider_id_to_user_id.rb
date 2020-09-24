class RenameTripsRiderIdToUserId < ActiveRecord::Migration[6.0]
  def change
    # rename_index :rides, :index_rider_id, :index_user_id
    # rename_column :rides, :rider_id, :user_id
    rename_index :trips, :index_trips_on_rider_id, :index_trips_on_user_id
    rename_column :trips, :rider_id, :user_id
  end
end
