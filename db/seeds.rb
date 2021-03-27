rider = Rider.create!(
  user_id: 1,
  refresh_token: "fake_refresh_token",
  access_token: "fake_access_token",
  athlete_json: {
    "firstname": "Noah",
    "lastname": "Silvera",
    "profile": "https://placekitten.com/400/400",
    "profile_medium": "https://placekitten.com/200/200"
  }
)

Rider.create!(
  user_id: 2,
  refresh_token: "fake_refresh_token",
  access_token: "fake_access_token",
  athlete_json: {
    "firstname": "Saskia",
    "lastname": "Kowalik",
    "profile": "https://placekitten.com/400/400",
    "profile_medium": "https://placekitten.com/200/200"
  }
)

rides = [
  Ride.create!(rider: rider, start_date: 2.hours.ago, activity_json: {}, activity_id: 1),
  Ride.create!(rider: rider, start_date: 1.hours.ago, activity_json: {}, activity_id: 2),
  Ride.create!(rider: rider, start_date: Time.zone.now, activity_json: {}, activity_id: 3)
]

Trip.create! name: "Past Bike Trip", rider: rider, start_date: 3.hours.ago, end_date: 1.day.from_now
Trip.create! name: "Current Bike Trip", rider: rider, start_date: 1.hours.ago, end_date: nil
