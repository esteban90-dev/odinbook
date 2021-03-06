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

        #add profile picture
        profile_image_path = Rails.root.join('spec','files','eiffel_tower.jpg')
        profile_image_file = fixture_file_upload(profile_image_path, 'image/jpg')
        user.profile.picture.attach(profile_image_file)

        #create a post - text only
        user.posts.create(body: "this is the first post")

        #create a post - text & picture
        post_image_path = Rails.root.join('spec','files','empire_state_building.jpg')
        post_image_file = fixture_file_upload(post_image_path, 'image/jpg')
        user.posts.create(body: "this is the second post", picture: post_image_file)
      end
    end

  end
end
