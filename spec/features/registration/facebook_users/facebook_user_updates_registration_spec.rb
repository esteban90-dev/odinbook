require 'rails_helper'

feature "facebook user updates registration" do

  scenario "changes name and email successfully" do
    facebook_user = FactoryBot.create(:user, :from_facebook)
    sign_in facebook_user

    visit edit_user_registration_path
    fill_in "Name", with: "somebody else"
    fill_in "Email", with: "somebody_else@example.com"
    click_on "Update"

    expect(page).to have_content("Your account has been updated successfully")
    expect(page).to have_content("signed in as somebody else")
  end

end