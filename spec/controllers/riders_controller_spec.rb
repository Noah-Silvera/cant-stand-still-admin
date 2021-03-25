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

  describe "/show" do
    let(:rider) { create :rider }

    subject { get "/riders/#{rider.user_id}" }

    it "responds with a success code" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "responds with json content" do
      subject
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "includes the riders user_id" do
      subject
      rider_res = JSON.parse response.body

      expect(rider_res["user_id"]).to eq(rider.user_id)
    end

    it "includes the riders name" do
      subject
      rider_res = JSON.parse response.body

      expect(rider_res["first_name"]).to eq("Sylvia")
      expect(rider_res["last_name"]).to eq("Rivera")
    end

    it "includes the riders profile pictures" do
      subject
      rider_res = JSON.parse response.body

      expect(rider_res["profile_picture"]).to eq("https://prof.pic")
      expect(rider_res["profile_picture_medium"]).to eq("https://medium.prof.pic")
    end

    it "doesn't return the access or refresh token" do
      subject
      rider_res = JSON.parse response.body

      expect(rider_res["access_token"]).to eq(nil)
      expect(rider_res["refresh_token"]).to eq(nil)
    end

    it "doesnt return the athlete JSON" do
      subject
      expect(JSON.parse(response.body)["athlete_json"]).to eq(nil)
    end
  end
end
