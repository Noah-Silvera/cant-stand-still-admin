class AddRidesAssociationToRider < ActiveRecord::Migration[6.0]
  def self.up
    add_column :rides, :rider_id, :integer
    add_index 'rides', ['rider_id'], :name => 'index_rider_id'
  end

  def self.down
    remove_column :rides, :rider_id
  end
end
