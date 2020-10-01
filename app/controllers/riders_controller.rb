class RidersController < ApplicationController
  def index
    authorize Rider
    render json: Rider.all.to_json(only: public_attrs, methods: public_methods)
  end

  def show
    @rider = Rider.find_by(user_id: params[:id])
    authorize @rider
    render json: @rider.to_json(only: public_attrs, methods: public_methods)
  end

  private

  def public_attrs
    [:user_id]
  end

  def public_methods
    [:first_name, :last_name]
  end

  def rider_params
    params.require(:rider).permit(:email)
  end
end
