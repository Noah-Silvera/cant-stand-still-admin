class RidersController < ApplicationController
  def index
    authorize Rider
    render json: Rider.select(*public_attrs).all
  end

  def show
    @rider = Rider.find_by(user_id: params[:id])
    authorize @rider
    # TODO -only permit certain things from being returned in this JSON
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
