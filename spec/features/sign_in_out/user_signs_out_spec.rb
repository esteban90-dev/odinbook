require 'rails_helper'

feature "user signs out" do

  scenario "successfully" do
    user = FactoryBot.create(:user)
    
    sign_in user
    visit root_path
    click_on "sign out"

    expect(page).to have_content("Signed out successfully")
  end

end