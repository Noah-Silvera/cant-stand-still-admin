# This will guess the User class
FactoryBot.define do
  factory :rider do
    sequence(:user_id, 0)
    athlete_json do
      {
        "id" => 22140740,
        "sex" => "F",
        "city" => "",
        "state" => "",
        "friend" => nil,
        "summit" => false,
        "country" => nil,
        "premium" => false,
        "profile" => "https://graph.facebook.com/345123123/picture?height=256&width=256",
        "follower" => nil,
        "firstname" => "Sylvia",
        "lastname" => "Rivera",
        "username" => nil,
        "created_at" => "2017-05-22T21:53:18Z",
        "updated_at" => "2020-04-15T04:56:08Z",
        "badge_type_id" => 0,
        "profile_medium" => "https://graph.facebook.com/234324234/picture?height=256&width=256",
        "resource_state" => 2
      }
    end
    access_token { "fake-access-token" }
    refresh_token { "fake-refresh-token" }
  end
end
