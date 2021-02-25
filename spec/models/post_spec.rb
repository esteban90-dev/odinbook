require 'rails_helper'

describe Post, "#likers" do

  it "returns a list of users that have liked the post" do 
    bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com") 
    frank = FactoryBot.create(:user, :with_blank_profile, name: "frank", email: "frank@example.com")
    alex = FactoryBot.create(:user, :with_blank_profile, name: "alex", email: "alex@example.com")

    bob.friends << [frank, alex]
    bob.posts.first.likes.create(liker: frank)
    bob.posts.first.likes.create(liker: alex)

    expect(bob.posts.first.likers).to include(frank, alex)
  end

end