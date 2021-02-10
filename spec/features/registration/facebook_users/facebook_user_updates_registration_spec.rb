require 'rails_helper'

feature "facebook user updates registration" do

  before(:each) do
    @facebook_user = FactoryBot.create(:user, :from_facebook)
    sign_in @facebook_user

    visit root_path
    click_on "edit account"
    fill_in "Name", with: "somebody else"
    fill_in "Email", with: "somebody_else@example.com"
    click_on "Update"
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Your account has been updated successfully")
  end

  scenario "they see that they are logged in with a different name" do 
    expect(page).to have_content("signed in as somebody else")
  end

  scenario "they see their account credentials change" do 
    click_on "edit account"
    
    expect(page).to have_field('user_name', with: "somebody else")
    expect(page).to have_field('user_email', with: "somebody_else@example.com")
  end
end