class CreateRides < ActiveRecord::Migration[6.0]
  def change
    create_table :rides do |t|

      t.timestamps
    end
  end
end
