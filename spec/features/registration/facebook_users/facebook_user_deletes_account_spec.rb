require 'rails_helper'

feature "facebook user deletes account" do

  before(:each) do 
    @facebook_user = FactoryBot.create(:user, :with_blank_profile, :from_facebook)
    sign_in @facebook_user

    visit root_path
    click_on "edit account"
    click_on "Cancel my account"
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Your account has been successfully cancelled")
  end
    
  scenario "the user no longer exists" do 
    expect(User.all).not_to include(@facebook_user)
  end

end