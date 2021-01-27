require 'rails_helper'

feature "regular user updates registration" do

  scenario "changes name and email successfully" do
    regular_user = FactoryBot.create(:user)
    
    sign_in regular_user
    visit edit_user_registration_path

    fill_in "Name", with: "somebody else"
    fill_in "Email", with: "somebody_else@example.com"
    fill_in "Current password", with: "#{regular_user.password}"
    click_on "Update"

    expect(page).to have_content("Your account has been updated successfully")
    expect(page).to have_content("signed in as somebody else")
  end

  scenario "changes password successfully" do
    regular_user = FactoryBot.create(:user)
    
    sign_in regular_user
    visit edit_user_registration_path

    fill_in "Password", with: "testpassword2"
    fill_in "Password confirmation", with: "testpassword2"
    fill_in "Current password", with: "#{regular_user.password}"
    click_on "Update"

    expect(page).to have_content("Your account has been updated successfully")
  end

end