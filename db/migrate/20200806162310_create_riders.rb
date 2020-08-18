class CreateRiders < ActiveRecord::Migration[6.0]
  def change
    create_table :riders do |t|
      t.string :email, null: false

      t.timestamps
    end
  end
end
