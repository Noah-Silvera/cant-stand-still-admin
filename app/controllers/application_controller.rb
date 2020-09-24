class ApplicationController < ActionController::API
  include ActionController::Helpers
  include Pundit
  helper_method :current_user

  def current_user
    Rider.find_by(id: session[:user_id])
  end
end
