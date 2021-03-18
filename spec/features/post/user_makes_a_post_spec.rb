require 'rails_helper'

feature "user makes a post" do 

  context "with text only" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      sign_in @bob

      visit root_path
      click_on "bob"
      fill_in "Body", with: "this is my first post"
      click_on "create post"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully made a post")
    end

    scenario "they see the posted text appear on their profile" do 
      expect(page).to have_content("this is my first post")
    end

  end

  context "with text and an image" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      sign_in @bob

      visit root_path
      click_on "bob"

      create_post_with_picture("this is my first post", "#{Rails.root}/spec/files/empire_state_building.jpg")
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully made a post")
    end

    scenario "they see the posted text appear on their profile" do 
      expect(page).to have_content("this is my first post")
    end

    scenario "they see the posted image appear on their profile" do 
      expect(page).to have_image("empire_state_building.jpg")
    end

  end

end