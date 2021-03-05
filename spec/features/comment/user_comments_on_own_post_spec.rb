require 'rails_helper'

feature "user comments on own post" do 

  scenario "they don't receive a notification" do 
    bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    sign_in bob

    visit root_path
    click_on "bob"
    comment_on_post(bob.posts.last, "I love my own posts so much")

    expect(bob.notifications.unacked.any?).to eq(false)
  end

end