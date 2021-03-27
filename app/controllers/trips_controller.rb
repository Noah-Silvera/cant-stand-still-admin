class TripsController < ApplicationController
  def index
    @rider = Rider.find_by(user_id: params[:rider_id]) || current_user

    respond_to do |format|
      format.html do
        return redirect_to_login unless current_user && current_user == @rider
        @trips = @rider.trips
        render
      end
      format.json { render json: @rider.trips.all }
    end
  end

  def show
    @trip = Trip.find params[:id]

  def edit
    @trip = Trip.find params[:id]
    @rider = @trip.rider

    return redirect_to_login unless current_user && current_user == @rider
    render
  end

  def update
    @trip = Trip.find params[:id]
    @rider = @trip.rider

    return redirect_to_login unless current_user && current_user == @rider

    @trip.update!(trip_params)
  end

  def create
    Trip.create(trip_params)
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :name)
  end
end
