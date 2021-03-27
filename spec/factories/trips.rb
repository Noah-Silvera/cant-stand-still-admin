FactoryBot.define do
  factory :trip do
    rider
    name { "ride_#{SecureRandom.base64(8)}" }
    start_date { 5.days.ago }
    end_date { 1.day.ago }
  end
end
