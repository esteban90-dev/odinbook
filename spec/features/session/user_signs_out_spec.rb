require 'rails_helper'

feature "user signs out" do

  before(:each) do 
    @user = FactoryBot.create(:user)
    
    sign_in @user
    visit root_path
    click_on "sign out"
  end

  scenario "they see a flash message" do
    expect(page).to have_content("Signed out successfully")
  end

  scenario "they don't appear signed in" do 
    expect(page).not_to have_content("signed in as")
  end

end