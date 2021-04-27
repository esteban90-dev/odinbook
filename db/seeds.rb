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

TEST_PICTURE_URLS = [ENV['test_picture_url_1'],
  ENV['test_picture_url_2'],
  ENV['test_picture_url_3'],
  ENV['test_picture_url_4'],
]

def random_education
  EDUCATION_OPTIONS[(rand*EDUCATION_OPTIONS.length).to_i]
end

def random_relationship_status
  RELATIONSHIP_STATUS_OPTIONS[(rand*RELATIONSHIP_STATUS_OPTIONS.length).to_i]
end

def random_user
  User.order('RANDOM()').first
end

def random_friend_of_user(user)
  user.friends.all.sample
end

def random_number(low_limit, high_limit)
  (rand*high_limit).to_i + low_limit
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

  puts "user #{user.id} profile created"
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

#create 10 posts per user - some will have an attached picture, some will have comments
User.all.each do |user|
  10.times do 
    #generate post
    post = user.posts.new(body: Faker::Quote.famous_last_words)

    #maybe attach a picture
    if random_number(1,4) == 1
      random_picture = Down.download(TEST_PICTURE_URLS[random_number(0,3)])
      random_picture_filename = File.basename(random_picture.path)
      post.picture.attach(io: random_picture, filename: random_picture_filename, content_type: 'image/png')
    end

    post.save

    #generate comments
    if random_number(1,3) == 1
      number_of_comments = random_number(1,5)
      number_of_comments.times do 
        post.comments.create(commenter: random_friend_of_user(user), body: Faker::Quote.famous_last_words)
      end
    end

  end

  puts "user #{user.id} posts created"
end

