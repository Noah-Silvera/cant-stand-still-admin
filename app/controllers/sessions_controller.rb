class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    @rider = Rider.find_or_create_from_auth_hash(auth_hash)
    return redirect_to "/login" unless @rider

    session["user_id"] = @rider.user_id
    redirect_to root_path
  end

  def login
    if current_user
      redirect_to root_path
    else
      render
    end
  end

  def logout
    session["user_id"] = nil
    redirect_to "/login"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
