rider = Rider.create! email: "noah.a.silvera@gmail.com", refresh_token: "fake_refresh_token", access_token: "fake_access_token"
rides = [Ride.create!(rider: rider), Ride.create(rider: rider), Ride.create(rider: rider)]
Trip.create! name: "Test Bike Trip", rides: rides, rider: rider
