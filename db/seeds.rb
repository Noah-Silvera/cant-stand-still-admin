rider = Rider.create! email: "noah.a.silvera@gmail.com"
rides = [Ride.create!(rider: rider), Ride.create(rider: rider), Ride.create(rider: rider)]
Trip.create! name: "Test Bike Trip", rides: rides, rider: rider
