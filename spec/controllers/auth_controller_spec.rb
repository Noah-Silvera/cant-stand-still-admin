require "rails_helper"

RSpec.describe "Auth Controller", type: :request do
  describe "/login" do
    context "strava returns the athlete" do
      subject { post "/login", params: {scope: ["read", "activity:read"], code: "12312"} }

      before do
        stub_request(:post, "https://www.strava.com/api/v3/oauth/token")
          .to_return(body: JSON.generate({
            access_token: "123123",
            refresh_token: "456456",
            athlete: {
              id: 1,
              username: "bob"
            }
          }))
      end

      it "responds with json and a success code" do
        subject
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
      end

      it "creates a new rider" do
        expect { subject }.to change { Rider.count }.from(0).to(1)
      end

      context "the rider already exists" do
        before do
          Rider.create(
            user_id: 1,
            access_token: "222",
            refresh_token: "333",
            athlete_json: {
              id: 1,
              username: "sam"
            }
          )
        end

        it "doesnt create a new rider" do
          expect { subject }.not_to change { Rider.count }.from(1)
        end

        it "updates the athlete json" do
          expect { subject }.to change { Rider.first.athlete_json["username"] }.from("sam").to("bob")
        end

        it "updates the access token" do
          expect { subject }.to change { Rider.first.access_token }.from("222").to("123123")
        end

        it "updates the refres token" do
          expect { subject }.to change { Rider.first.refresh_token }.from("333").to("456456")
        end
      end

      it "assigns the access and refresh token to the rider" do
        subject
        expect(Rider.first).to have_attributes(access_token: "123123", refresh_token: "456456")
      end

      it "assigns a user id to the rider" do
        subject
        expect(Rider.first).to have_attributes(user_id: 1)
      end

      it "stores the athlete json for the rider" do
        subject
        expect(Rider.first).to have_attributes(athlete_json: {
          "id" => 1,
          "username" => "bob"
        })
      end

      it "sets a session variable" do
        subject
        expect(session[:user_id]).to eq(1)
      end
    end

    context "scope doesn't include read permission" do
      it "enforces the required scope" do
        post "/login", params: {scope: ["activity:read"]}

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include("The application requires access to reading your profile and activities")
      end
    end

    context "scope doesn't include read activity permission" do
      it "enforces the required scope" do
        post "/login", params: {scope: ["read"]}

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include("The application requires access to reading your profile and activities")
      end
    end

    context "strava code is invalid or expired" do
      it "returns an unknown error" do
        stub_request(:post, "https://www.strava.com/api/v3/oauth/token")
          .to_return(status: 200, body: "{}", headers: {})

        post "/login", params: {scope: ["read", "activity:read"], code: "12312badCode"}

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include("Could not login with strava for an unknown reason")
      end
    end

    context "strava API returns an authorization error" do
      it "returns an authorization error" do
        stub_request(:post, "https://www.strava.com/api/v3/oauth/token")
          .to_return(body: JSON.generate({
            errors: [
              {
                resource: "AuthorizationCode",
                code: "expired"
              }
            ]
          }))
        post "/login", params: {scope: ["read", "activity:read"], code: "12312"}

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include("Login authorization expired, please try again")
      end
    end
  end
end
