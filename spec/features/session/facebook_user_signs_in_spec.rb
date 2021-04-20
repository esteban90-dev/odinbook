require 'rails_helper'

feature "facebook user signs in" do 

  before(:each) do
    FactoryBot.create(:user, :with_profile, :from_facebook)
    stub_omniauth_successful

    visit root_path
    click_on "sign in"
    click_on "Sign in with Facebook"
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Signed in successfully")
  end

  scenario "they see that they are signed in" do 
    user_appears_signed_in("somebody")
  end

end