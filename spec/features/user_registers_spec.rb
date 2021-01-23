require 'rails_helper'

feature "user registers" do

  scenario "successfully" do
    visit root_path

    click_on "sign up"
    fill_in "Name", with: "somebody"
    fill_in "Email", with: "somebody@example.com"
    fill_in "Password", with: "testpassword"
    fill_in "Password confirmation", with: "testpassword"
    click_on "Sign up"

    expect(page).to have_content("You have signed up successfully")
    expect(page).to have_content("signed in as somebody")
    expect(page).not_to have_content("somebody@example.com")
  end

end