class RemoveRideTripsForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :rides, :trips
  end
end
