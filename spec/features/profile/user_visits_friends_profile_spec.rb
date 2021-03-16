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
    expect(page.body.index(@post_2.body) < page.body.index(@post_1.body)).to eq(true)
  end

  scenario "they don't see a form to create a post" do 
    expect(page).not_to have_field("Body")
    expect(page).not_to have_field("Picture")
    expect(page).not_to have_button("create post")
  end

  scenario "they see their friend's friends" do 
    @sean = FactoryBot.create(:user, name: "sean", email: "sean@example.com")
    @alex = FactoryBot.create(:user, name: "alex", email: "alex@example.com")
    @bob.friends << [@frank, @sean, @alex]

    click_on "friends"

    expect(page).to have_content("frank")
    expect(page).to have_content("sean")
    expect(page).to have_content("alex")
  end

  scenario "they don't see the edit profile link" do 
    expect(page).not_to have_link("edit profile")
  end

  scenario "they don't see the 'friend requests' link" do 
    expect(page).not_to have_link("friend requests")
  end

end