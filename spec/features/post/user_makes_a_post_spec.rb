require 'rails_helper'

feature "user makes a post" do 

  before(:each) do 
    bob = FactoryBot.create(:user, :with_blank_profile, name: "bob", email: "bob@example.com")
    sign_in bob

    visit root_path
    click_on "bob"
    fill_in "Body", with: "this is my first post"
    click_on "create post"
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Successfully made a post")
  end

  scenario "they see it appear on their profile" do 
    expect(page).to have_content("this is my first post")
  end

end