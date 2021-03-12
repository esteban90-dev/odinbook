require 'rails_helper'

feature "user deletes a post" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @post = @bob.posts.create(body: "this is a post")

    sign_in @bob
    visit root_path 
    click_on "bob"

    find("##{@post.id}").click_on "delete"
  end
  
  scenario "the post no longer exists" do 
    expect(page).not_to have_content("this is a post")
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Post successfully destroyed")
  end

end