require 'rails_helper'

feature "facebook user registers" do 

  context "successfully" do 

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

    scenario "they receive a notification with a link that tells them to edit their profile" do 
      visit root_path
      click_on "notifications"
      
      user_sees_edit_profile_notification
    end

    scenario "a blank profile is created for them" do 
      expect(User.first.profile).not_to eq(nil)
    end

    scenario "they see the edit profile page" do 
      expect(page.current_path).to eq(edit_user_profile_path(User.first))
    end

  end

end