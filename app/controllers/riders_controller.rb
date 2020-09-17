class RidersController < ApplicationController
  def index
    render json: Rider.all
  end

  def show
    @rider = Rider.find params[:id]
    render json: @rider
  end

  private

  def rider_params
    params.require(:rider).permit(:email)
  end
end
