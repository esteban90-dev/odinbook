require 'rails_helper'

feature "user visits non friend's profile" do 

  before(:each) do 
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    bob.posts.create(body: "this is a post")
    frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")

    sign_in frank
    visit root_path
    click_on "users"
    click_on "bob"
  end

  scenario "they don't see a comment form associated with the non friend's posts" do 
    user_doesnt_see_comment_form
  end

  scenario "they don't see a like button associated with the non friend's posts" do 
    expect(page).not_to have_like_button
  end

  scenario "they don't see the 'friends' link" do 
    expect(page).not_to have_link("friends")
  end

end