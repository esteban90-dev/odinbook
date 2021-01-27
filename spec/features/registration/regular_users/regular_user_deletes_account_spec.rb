require 'rails_helper'

feature "regular user deletes account" do

  scenario "successfully" do

    regular_user = FactoryBot.create(:user)
    sign_in regular_user

    visit edit_user_registration_path
    
    click_on "Cancel my account"

    expect(page).to have_content("Your account has been successfully cancelled")
    expect(User.all).not_to include(regular_user)
  end

end