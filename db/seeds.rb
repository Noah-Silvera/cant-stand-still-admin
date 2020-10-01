Rider.create!(
  user_id: 1,
  refresh_token: "fake_refresh_token",
  access_token: "fake_access_token",
  athlete_json: {
    "firstname": "Noah",
    "lastname": "Silvera"
  }
)

rider = Rider.create!(
  user_id: 2,
  refresh_token: "fake_refresh_token",
  access_token: "fake_access_token",
  athlete_json: {
    "firstname": "Saskia",
    "lastname": "Kowalik"
  }
)

rides = [
  Ride.create!(rider: rider),
  Ride.create!(rider: rider),
  Ride.create!(rider: rider)
]

Trip.create! name: "Test Bike Trip", rides: rides, rider: rider
