FactoryBot.define do
  factory :profile do
    location { "New York" }
    education { "High School" }
    relationship_status { "Single" }
    association :user
  end
end