class RidersController < ApplicationController
  def index
    authorize Rider
    render json: Rider.select(*public_attrs).all
  end

  def show
    @rider = Rider.select(*public_attrs).find_by(user_id: params[:id])
    authorize @rider
    render json: @rider
  end

  private

  def public_attrs
    [:user_id]
  end

  def rider_params
    params.require(:rider).permit(:email)
  end
end
