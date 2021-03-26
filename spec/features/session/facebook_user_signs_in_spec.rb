require 'rails_helper'

feature "facebook user signs in" do 

  context "auth hash provides valid data" do 

    before(:each) do
      stub_omniauth_successful

      visit root_path
      click_on "sign in"
      click_on "Sign in with Facebook"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("signed in as somebody")
    end

    scenario "they see that they are signed in" do 
      expect(page).to have_content("Signed in successfully")
    end

  end

  context "auth hash doesn't provide valid data - missing email" do 

    before(:each) do 
      stub_omniauth_unsuccessful

      visit root_path
      click_on "sign in"
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