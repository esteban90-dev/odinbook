require 'rails_helper'

feature "user visits friendships index" do 

  context "with no friendships" do 

    scenario "'no friends yet' is displayed" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")

      sign_in bob
      visit root_path
      find(nav_section).click_on "bob"
      click_on "friends"

      expect(page).to have_content("no friends yet")
    end

  end

end