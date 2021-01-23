require 'rails_helper'

feature "user signs in with facebook" do 

  scenario "successfully" do 
    stub_omniauth_successful

    visit root_path
    click_on "sign in"
    click_on "Sign in with Facebook"

    expect(page).to have_content("signed in as somebody")
  end

  scenario "unsuccessfully - auth hash doesn't provide email" do
    stub_omniauth_unsuccessful

    visit root_path
    click_on "sign in"
    click_on "Sign in with Facebook"

    expect(page).to have_content("Email can't be blank")
    expect(page).not_to have_content("Password can't be blank")
  end

end