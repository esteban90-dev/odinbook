require 'rails_helper'

feature "user likes a friend's post" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @frank.friends << @bob
    @post = @bob.posts.create(body: "this is a post")
    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"
  
    like(@post)
  end

  scenario "the user sees the like count increment" do 
    expect(page).to have_post_with_likes(@post, 1)
  end

  scenario "the user doesn't see the like button anymore" do 
    user_doesnt_see_post_like_button(@post)
  end

  scenario "the user now sees an 'unlike' button" do 
    user_sees_post_unlike_button(@post)
  end

  scenario "the friend receives a notification" do 
    sign_out @frank
    sign_in @bob
    visit root_path
    click_on "notifications"

    expect(page).to have_content("frank liked your post")
  end

  scenario "the friend clicks the link in the notification and is brought back to the original post" do 
    sign_out @frank
    sign_in @bob
    visit root_path
    click_on "notifications"

    click_post_link_in_notification(@bob.notifications.first)

    expect(page).to have_content(@post.body)
  end

end