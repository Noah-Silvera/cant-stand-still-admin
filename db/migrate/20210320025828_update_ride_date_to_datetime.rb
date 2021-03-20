class UpdateRideDateToDatetime < ActiveRecord::Migration[6.1]
  def change
    change_column :rides, :start_date, :datetime
  end
end
