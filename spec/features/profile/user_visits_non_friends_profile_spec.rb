require 'rails_helper'

feature "user visits non friend's profile" do 

  scenario "they don't see a comment form associated with the non friend's posts" do 
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    bob.posts.create(body: "this is a post")
    frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")

    sign_in frank
    visit root_path
    click_on "users"
    click_on "bob"

    user_doesnt_see_comment_form
  end

end