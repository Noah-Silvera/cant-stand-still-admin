class RemoveRideTripAssociation < ActiveRecord::Migration[6.1]
  def change
    remove_index :rides, name: "index_trip_id"
    remove_column :rides, :trip_id
  end
end
