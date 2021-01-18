class AddJsonRideColumnToRides < ActiveRecord::Migration[6.0]
  def change
    add_column :rides, :activity_json, :jsonb, null: false
    add_column :rides, :activity_id, :text, null: false
    add_column :rides, :start_date, :date, null: false

    add_index :rides, :activity_json, using: :gin
    add_index :rides, :activity_id
    add_index :rides, :start_date
  end
end
