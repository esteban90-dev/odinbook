FactoryBot.define do
  factory :profile do
    location { "New York" }
    education { "High School" }
    relationship_status { "Single" }
    association :user
    picture { Rack::Test::UploadedFile.new('spec/files/generic-user-icon-19.png', 'image/jpg') }
  end
end