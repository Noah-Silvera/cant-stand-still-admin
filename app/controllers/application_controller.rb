class ApplicationController < ActionController::Base
  include ActionController::Helpers
  include Pundit
  helper_method :current_user

  def current_user
    Rider.find_by(id: session[:user_id])
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
