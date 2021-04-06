FactoryBot.define do
  factory :user do
    email { "somebody@example.com" }
    name { "somebody" }
    password { "testpassword" }

    trait :from_facebook do
      provider { "facebook" }
      uid { "12345" }
    end

    trait :with_profile do 
      after(:create){ |user| create(:profile, user: user) }
    end
  end
end
