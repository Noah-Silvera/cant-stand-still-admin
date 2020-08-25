class TripsController < ApplicationController
  def index
    render json: Trip.all
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
