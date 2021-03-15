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
  
    find("##{@post.id}").click_on "like"
  end

  scenario "the user sees the like count increment" do 
    expect(page).to have_css("##{@post.id}", text: "likes: 1")
  end

  scenario "the user doesn't see the like button anymore" do 
    expect(page).not_to have_link("like", exact: true)
  end

  scenario "the user now sees an 'unlike' button" do 
    expect(page).to have_link("unlike")
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

    click_on "post"

    expect(page).to have_content(@post.body)
  end

end