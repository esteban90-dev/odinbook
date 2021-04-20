require 'rails_helper'

feature "user visits friend's profile" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @post_1 = @bob.posts.create(body: "this is a post")
    @post_2 = @bob.posts.create(body: "this is another post")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @bob.friends << @frank
    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"
  end

  scenario "they see their friend's posts in descending order" do 
    user_sees_content_order_descending(@post_1.body, @post_2.body)
  end

  scenario "they don't see a form to create a post" do 
    user_doesnt_see_post_form
  end

  scenario "they see their friend's friends" do 
    @sean = FactoryBot.create(:user, name: "sean", email: "sean@example.com")
    @alex = FactoryBot.create(:user, name: "alex", email: "alex@example.com")
    @bob.friends << [@sean, @alex]

    click_on "friends"

    expect(page).to have_content("frank")
    expect(page).to have_content("sean")
    expect(page).to have_content("alex")
  end

  scenario "they don't see an 'unfriend' link next to their friend's friends" do 
    click_on "friends"

    expect(page).not_to have_link("unfriend")
  end

  scenario "they don't see an edit link next to the friend's posts" do 
    post_doesnt_appear_editable(@post_1)
  end

  scenario "they don't see a delete link next to the friend's posts" do 
    post_doesnt_appear_deletable(@post_1)
  end

  scenario "they don't see the edit profile link" do 
    expect(page).not_to have_link("edit profile")
  end

  scenario "they don't see the 'friend requests' link" do 
    expect(page).not_to have_link("friend requests")
  end

end