class RideFactory
  def self.create!(rider, activity_json)
    rider.rides.create!(
      activity_json: activity_json,
      activity_id: activity_json["id"],
      start_date: activity_json["start_date"]
    )
  end
end
