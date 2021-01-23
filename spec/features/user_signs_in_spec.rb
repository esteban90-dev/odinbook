require "rails_helper"

feature "user signs in" do 

  scenario "successfully" do 
    user = FactoryBot.create(:user)

    visit root_path
    click_on "sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Sign in"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("signed in as #{user.name}")
  end

end