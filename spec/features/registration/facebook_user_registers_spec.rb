require 'rails_helper'

feature "facebook user registers" do 

  before(:each) do
    stub_omniauth_successful

    visit root_path

    click_on "sign up"
    click_on "Sign in with Facebook"
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Signed in successfully")
  end
    
  scenario "they see that they are signed in" do 
    expect(page).to have_content("signed in as somebody")
  end

  scenario "they see their account credentials" do 
    click_on "edit account"

    expect(page).to have_field('user_name', with: "somebody")
    expect(page).to have_field('user_email', with: "somebody@example.com")
  end

end