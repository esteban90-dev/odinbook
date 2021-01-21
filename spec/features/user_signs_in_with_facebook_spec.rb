require 'rails_helper'

feature "user signs in with facebook" do 

  scenario "successfully" do 
    stub_omniauth_successful

    visit root_path
    click_on "sign in"
    click_on "Sign in with Facebook"

    expect(page).to have_content("signed in as somebody")
  end

end