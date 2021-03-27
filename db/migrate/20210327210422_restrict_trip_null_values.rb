class RestrictTripNullValues < ActiveRecord::Migration[6.1]
  def change
    change_column :trips, :start_date, :datetime, null: false
    change_column :trips, :name, :string, null: false
  end
end
