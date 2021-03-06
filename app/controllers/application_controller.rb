class ApplicationController < ActionController::Base
  include ActionController::Helpers
  helper_method :current_user

  def current_user
    Rider.find_by(user_id: session[:user_id])
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def redirect_to_login
    redirect_to "/login"
  end

  def ensure_logged_in
    return redirect_to_login unless (current_user && current_user == @rider)
  end

  def json_format?
    request.format.json?
  end
end
