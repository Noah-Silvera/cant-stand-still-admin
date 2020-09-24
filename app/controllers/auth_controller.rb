require "uri"
require "net/http"

class AuthController < ApplicationController
  def login
    unless params[:scope]&.include?("read") && params[:scope]&.include?("activity:read")
      return render json: {message: "The application requires access to reading your profile and activities"}, status: :unauthorized
    end

    token_params = {
      client_secret: Rails.application.credentials.strava_client_secret,
      client_id: "22020",
      code: params[:code]
    }

    body = JSON.parse Net::HTTP.post_form(URI.parse("https://www.strava.com/oauth/token"), token_params).body

    unless body && body["access_token"] && body["refresh_token"]
      if body["errors"]
        if body["errors"].any? { |error| error["resource"] == "AuthorizationCode" && error["code"] == "expired" }
          return render json: {message: "Login authorization expired, please try again"}, status: :unauthorized
        end
      end

      Rails.logger.error "Could not login with strava. Error: #{body}"
      return render json: {message: "Could not login with strava for an unknown reason"}, status: :internal_server_error
    end

    rider = Rider.find_or_initialize_by(user_id: body["athlete"]["id"])
    rider.update!(athlete_json: body["athlete"], access_token: body["access_token"], refresh_token: body["refresh_token"])
    rider.save!

    session[:user_id] = rider.user_id
    render json: {id: rider.user_id}, status: :ok
  end
end
