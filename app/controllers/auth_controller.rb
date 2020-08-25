require "uri"
require "net/http"

class AuthController < ApplicationController
  def login
    token_params = {
      client_secret: Rails.application.secrets[:strava_client_secret],
      client_id: "22020",
      code: params[:code]
    }

    response = JSON.parse Net::HTTP.post_form(URI.parse('https://www.strava.com/oauth/token'), token_params).body

    puts "Access Token: " + response["access_token"]
    puts "Refresh Token: " + response["refresh_token"]
  end
end
