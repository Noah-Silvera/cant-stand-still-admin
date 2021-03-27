class TripsController < ApplicationController
  before_action :set_rider, only: [:index, :new, :create]
  before_action :set_trip_and_rider, except: [:index, :new, :create]
  before_action :ensure_logged_in, only: [:edit, :update, :create, new]
  before_action :ensure_logged_in, only: [:index, :show], unless: :json_format?

  def index
    respond_to do |format|
      format.html do
        @trips = @rider.trips
        render
      end
      format.json { render json: @rider.trips.all }
    end
  end

  def show
    respond_to do |format|
      format.html do
        render
      end
      format.json { render json: @trip }
    end
  end

  def edit
    render
  end

  def update
    @trip.update!(trip_params)

    redirect_to trip_path(@trip)
  end

  def new
    @trip = @rider.trips.build
    render
  end

  def create
    @trip = @rider.trips.create!(trip_params)
    if trip_ongoing?
      @trip.update!(end_date: nil)
    end
    redirect_to trip_path(@trip)
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :name)
  end

  def trip_ongoing?
    params.require(:trip).require(:ongoing) == "1"
  end

  def set_rider
    @rider = Rider.find_by(user_id: params[:rider_id]) || current_user
  end

  def set_trip_and_rider
    @trip = Trip.find params[:id]
    @rider = @trip.rider
  end
end
