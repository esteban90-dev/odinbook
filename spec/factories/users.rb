FactoryBot.define do
  factory :user do
    email { "somebody@example.com" }
    name { "somebody" }
    password { "testpassword" }

    trait :from_facebook do
      provider { "facebook" }
      uid { "1234" }
    end

    trait :with_example_profile do 
      after(:create) do |user| 
        user.profile.update({
          location: "New York, NY",
          education: "Bachelor's Degree",
          relationship_status: "Single",
        })

        image_path = Rails.root.join('spec','files','eiffel_tower.jpg')
        image_file = fixture_file_upload(image_path, 'image/jpg')
        user.profile.picture.attach(image_file)

        user.posts.create(body: "this is the first post")
        user.posts.create(body: "this is the second post")
      end
    end

  end
end
