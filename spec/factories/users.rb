FactoryBot.define do
  factory :user do
    email { "somebody@example.com" }
    name { "somebody" }
    password { "testpassword" }

    trait :from_facebook do
      provider { "facebook" }
      uid { "1234" }
    end

  end
end
