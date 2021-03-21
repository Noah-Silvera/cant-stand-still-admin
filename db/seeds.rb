rider = Rider.create!(
  user_id: 1,
  refresh_token: "fake_refresh_token",
  access_token: "fake_access_token",
  athlete_json: {
    "firstname": "Noah",
    "lastname": "Silvera"
  }
)

Rider.create!(
  user_id: 2,
  refresh_token: "fake_refresh_token",
  access_token: "fake_access_token",
  athlete_json: {
    "firstname": "Saskia",
    "lastname": "Kowalik"
  }
)

rides = [
  Ride.create!(rider: rider, start_date: 2.hours.ago, activity_json: {}, activity_id: 1),
  Ride.create!(rider: rider, start_date: 1.hours.ago, activity_json: {}, activity_id: 2),
  Ride.create!(rider: rider, start_date: Time.zone.now, activity_json: {}, activity_id: 3)
]

Trip.create! name: "Test Bike Trip", rides: rides, rider: rider
