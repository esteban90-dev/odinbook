# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

EDUCATION_OPTIONS = ["High School", "Associate's Degree", "Bachelor's Degree", "Master's Degree", "Doctoral Degree"]
RELATIONSHIP_STATUS_OPTIONS = ["Single", "In a Relationship", "Married"]

def random_education
  EDUCATION_OPTIONS[(rand*EDUCATION_OPTIONS.length).to_i]
end

def random_relationship_status
  RELATIONSHIP_STATUS_OPTIONS[(rand*RELATIONSHIP_STATUS_OPTIONS.length).to_i]
end

def random_user
  User.order('RANDOM()').first
end

#create 30 users
30.times do 
  #create user
  user = User.create(
    email: Faker::Internet.unique.email,
    name: Faker::Name.name,
    password: ENV['test_password'],
    #don't send confirmation email
    skip_email: true
  )

  puts "user #{user.id} created"
end

#create a profile for each user
User.all.each do |user|
  profile = user.create_profile(
    location: Faker::Address.city,
    education: random_education,
    relationship_status: random_relationship_status
  )

  #attach profile picture
  profile.picture.attach(io: File.open('app/assets/images/generic-user-icon-10.jpg'), filename: 'generic-user-icon-10.jpg', content_type: 'image/png')

  puts "user #{user.id} profile created"
end

#create 10 posts per user
User.all.each do |user|
  10.times{ user.posts.create(body: Faker::Quote.famous_last_words) }

  puts "user #{user.id} posts created"
end

#assign each user 5 random friends
User.all.each do |user|
  while user.friends.count <= 5
    random_user = User.all.sample
    unless user.friends.include?(random_user)
      user.friends << random_user
      puts "user #{user.id} is now friends with #{random_user.id}"
    end
  end
end