require 'rails_helper'

describe Post, "#likers" do

  it "returns a list of users that have liked the post" do 
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com") 
    frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    alex = FactoryBot.create(:user, name: "alex", email: "alex@example.com")

    post = bob.posts.create(body: "this is a post")
    bob.friends << [frank, alex]
    post.likes.create(liker: frank)
    post.likes.create(liker: alex)

    expect(post.likers).to include(frank, alex)
  end

end