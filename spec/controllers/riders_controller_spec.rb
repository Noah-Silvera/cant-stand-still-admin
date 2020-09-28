require "rails_helper"

RSpec.describe "Auth Controller", type: :request do
  describe "/index" do
    subject { get "/riders" }

    context "no riders exist" do
      it "responds with a success code" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "responds with json content" do
        subject
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "returns an empty array" do
        subject
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context "some riders exist" do
      let!(:rider_one) { create :rider }
      let!(:rider_two) { create :rider }

      it "responds with a success code" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "responds with json content" do
        subject
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "returns an array of the riders" do
        subject
        riders_res = JSON.parse response.body

        expect(riders_res.count).to eq(2)
        expect(riders_res.first["user_id"]).to eq(rider_one.user_id)
        expect(riders_res.last["user_id"]).to eq(rider_two.user_id)
      end

      it "doesn't return the access or refresh token" do
        subject
        riders_res = JSON.parse response.body

        expect(riders_res.first["access_token"]).to eq(nil)
        expect(riders_res.first["refresh_token"]).to eq(nil)
      end

      it "doesnt return the athlete JSON" do
        subject
        expect(JSON.parse(response.body).first["athlete_json"]).to eq(nil)
      end
    end
  end
end
