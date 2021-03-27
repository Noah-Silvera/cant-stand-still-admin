class TripsController < ApplicationController
  def index
    @rider = Rider.find_by user_id: params[:rider_id] || current_user

    respond_to do |format|
      format.html do
        return redirect_to_login unless current_user
        @trips = @rider.trips
        render
      end
      format.json { render json: @rider.trips.all }
    end
  end

  def show
    @trip = Trip.find params[:id]
    render json: @trip
  end

  def create
    Trip.create(trip_params)
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :name)
  end
end
