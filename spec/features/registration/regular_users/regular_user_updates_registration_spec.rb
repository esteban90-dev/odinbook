require 'rails_helper'

feature "regular user updates registration" do

  context "they change their name and email" do
  
    before(:each) do 
      regular_user = FactoryBot.create(:user, :with_blank_profile)
    
      sign_in regular_user
      visit root_path
      click_on "edit account"
      fill_in "Name", with: "somebody else"
      fill_in "Email", with: "somebody_else@example.com"
      fill_in "Current password", with: "#{regular_user.password}"
      click_on "Update"
    end
    
    scenario "they see a flash message" do 
      expect(page).to have_content("Your account has been updated successfully")
    end
    
    scenario "they see that they are logged in with their new name" do 
      expect(page).to have_content("signed in as somebody else")
    end

    scenario "they see their account credentials change" do 
      click_on "edit"

      expect(page).to have_field('user_name', with: "somebody else")
      expect(page).to have_field('user_email', with: "somebody_else@example.com")
    end

  end

  context "they change their password successfully" do

    before(:each) do 
      @regular_user = FactoryBot.create(:user, :with_blank_profile)
      
      sign_in @regular_user
      visit edit_user_registration_path

      fill_in "Password", with: "testpassword2"
      fill_in "Password confirmation", with: "testpassword2"
      fill_in "Current password", with: @regular_user.password
      click_on "Update"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Your account has been updated successfully")
    end

    scenario "they are able to sign in with their new password" do 
      sign_out @regular_user
      visit root_path
      click_on "sign in"
      fill_in "Email", with: @regular_user.email
      fill_in "Password", with: "testpassword2"
      click_on "Sign in"
      
      expect(page).to have_content("signed in as somebody")
    end

  end

end