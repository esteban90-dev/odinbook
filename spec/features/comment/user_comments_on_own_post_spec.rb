require 'rails_helper'

feature "user comments on own post" do 

  scenario "they don't receive a notification" do 
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @post = bob.posts.create(body: "this is a post")
    sign_in bob

    visit root_path
    click_on "bob"
    comment_on_post(@post, "I love my own posts so much")

    expect(bob.notifications.unacked.any?).to eq(false)
  end

end