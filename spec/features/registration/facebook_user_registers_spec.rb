require 'rails_helper'

feature "facebook user registers" do 

  context "auth hash provides valid data" do 

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
      user_appears_signed_in("somebody")
    end

    scenario "they see the edit profile page" do 
      expect(page).to have_current_path(edit_user_profile_path(User.first))
    end

  end

  context "auth hash doesn't provide valid data - missing email" do 

    before(:each) do 
      stub_omniauth_unsuccessful

      visit root_path
      click_on "sign up"
      click_on "Sign in with Facebook"
    end

    scenario "they see that the email field can't be blank" do 
      expect(page).to have_content("Email can't be blank")
    end
      
    scenario "they do not see 'Password can't be blank'" do 
      expect(page).not_to have_content("Password can't be blank")
    end

  end

end