require 'rails_helper'

feature "facebook user deletes account" do

  scenario "successfully" do 

    facebook_user = FactoryBot.create(:user, :from_facebook)
    sign_in facebook_user

    visit edit_user_registration_path 
    click_on "Cancel my account"

    expect(page).to have_content("Your account has been successfully cancelled")
    expect(User.all).not_to include(facebook_user)
  end

end