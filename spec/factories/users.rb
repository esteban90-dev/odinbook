FactoryBot.define do
  factory :user do
    email { "somebody@example.com" }
    name { "somebody" }
    password { "testpassword" }

    trait :from_facebook do
      provider { "facebook" }
      uid { "1234" }
    end

    trait :with_blank_profile do 
      after(:create){ |user| user.create_profile({}) }
    end
  end
end
