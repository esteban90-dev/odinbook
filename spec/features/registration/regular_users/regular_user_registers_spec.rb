require 'rails_helper'

feature "regular user registers" do

  context "successfully" do 

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

    scenario "they receive a notification with a link that tells them to create their profile" do 
      visit root_path
      click_on "notifications"
      
      user_sees_create_profile_notification
    end

  end

  context "unsuccessfully" do 

    scenario "they see that their password must be at least 8 characters" do
      visit root_path

      click_on "sign up"
      fill_in "Name", with: "somebody"
      fill_in "Email", with: "somebody@example.com"
      fill_in "Password", with: "1234567"
      fill_in "Password confirmation", with: "1234567"
      click_on "Sign up"
    
      expect(page).to have_content("Password is too short")
    end

    scenario "they see that the email they entered has already been taken" do
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