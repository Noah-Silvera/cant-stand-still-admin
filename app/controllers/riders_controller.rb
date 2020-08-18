class RidersController < ApplicationController
  def index
    render json: Rider.all
  end

  def show
    @rider = Rider.find params[:id]
    render json: @rider
  end

  def create
    Rider.create(rider_params)
  end

  private

  def rider_params
    params.require(:rider).permit(:email)
  end
end
