class AddRidesAssociationToTrip < ActiveRecord::Migration[6.0]
  def self.up
    add_column :rides, :trip_id, :integer
    add_index 'rides', ['trip_id'], :name => 'index_trip_id'
  end

  def self.down
    remove_column :rides, :trip_id
  end
end
