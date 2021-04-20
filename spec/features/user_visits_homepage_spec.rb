require 'rails_helper'

feature "user visits homepage" do 

  context "as an unauthenticated user" do 

    scenario "they are redirected to the sign in page" do 
      visit root_path

      expect(page).to have_current_path(new_user_session_path)
    end

    scenario "they don't see a flash message" do 
      visit root_path

      expect(page).not_to have_content("You need to sign in or sign up before continuing.")
    end

  end

  context "as an authenticated user" do 

    scenario "they are redirected to the timeline" do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com" )
      sign_in @bob

      visit root_path

      expect(page).to be_timeline
    end

  end

end
