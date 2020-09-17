class AddAthleteJsonToRider < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :athlete_json, :jsonb, null: false
  end
end
