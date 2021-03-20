class AddAppropriateForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :rides, :riders, column: "user_id"
    add_foreign_key :rides, :trips
  end
end
