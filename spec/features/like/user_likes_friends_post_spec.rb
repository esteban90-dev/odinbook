require 'rails_helper'

feature "user likes a friend's post" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, :with_blank_profile, name: "frank", email: "frank@example.com")
    @frank.friends << @bob
    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"
    @post = @bob.posts.last
    like(@post)
  end

  scenario "the user sees the like count increment" do 
    user_sees_post_with_likes(@post, 1)
  end

  scenario "the user sees the 'like' button become an 'unlike' button" do 
    user_sees_post_unlike_button(@post)
  end

  scenario "the friend receives a notification" do 
    sign_out @frank
    sign_in @bob
    visit root_path
    click_on "notifications"

    user_sees_post_like_notification(@frank, @post)
  end

end