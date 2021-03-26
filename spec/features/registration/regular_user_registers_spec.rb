require 'rails_helper'

feature "regular user registers" do

  context "with valid data" do 

    before(:each) do
      visit root_path

      click_on "sign up"
      fill_in "Name", with: "somebody"
      fill_in "Email", with: "somebody@example.com"
      fill_in "Password", with: "testpassword"
      fill_in "Password confirmation", with: "testpassword"
      click_on "Sign up"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("You have signed up successfully")
    end
      
    scenario "they see that they are signed in" do 
      expect(page).to have_content("signed in as somebody")
    end

    scenario "they see their account credentials" do 
      click_on "edit account"

      expect(page).to have_field('user_name', with: "somebody")
      expect(page).to have_field('user_email', with: "somebody@example.com")
    end

    scenario "they see a welcome notification" do 
      visit root_path
      click_on "notifications"
      
      expect(page).to have_content("Welcome to Odinbook!")
    end

    scenario "they see the edit profile page" do 
      expect(page.current_path).to eq(edit_user_profile_path(User.first))
    end

  end

  context "with a password that is too short" do 

    scenario "they see an error message" do
      visit root_path

      click_on "sign up"
      fill_in "Name", with: "somebody"
      fill_in "Email", with: "somebody@example.com"
      fill_in "Password", with: "1234567"
      fill_in "Password confirmation", with: "1234567"
      click_on "Sign up"
    
      expect(page).to have_content("Password is too short")
    end

  end

  context "with an email that has already been taken" do 

    scenario "they see an error message" do
      FactoryBot.create(:user)

      visit root_path

      click_on "sign up"
      fill_in "Name", with: "somebody"
      fill_in "Email", with: "somebody@example.com"
      fill_in "Password", with: "12345678"
      fill_in "Password confirmation", with: "12345678"
      click_on "Sign up"

      expect(page).to have_content("Email has already been taken")
    end

  end
  
end