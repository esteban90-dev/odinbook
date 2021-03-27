require "rails_helper"

feature "user creates profile" do 

  context "with valid data" do 
    before(:each) do
      visit root_path

      click_on "sign up"
      fill_in "Name", with: "somebody"
      fill_in "Email", with: "somebody@example.com"
      fill_in "Password", with: "testpassword"
      fill_in "Password confirmation", with: "testpassword"
      click_on "Sign up"
      fill_in "Location", with: "New York"
      select("Master's Degree", from: "Education")
      select('Single', from: "Relationship Status")
      attach_file "Picture", "#{Rails.root}/spec/files/eiffel_tower.jpg"

      click_on "Create Profile"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully created profile")
    end

    scenario "they see a welcome notification" do 
      visit root_path
      click_on "notifications"
      
      expect(page).to have_content("Welcome to Odinbook!")
    end

    scenario "they see their location" do 
      expect(page).to have_content("New York")
    end
  
    scenario "they see their education" do 
      expect(page).to have_content("Master's Degree")
    end
  
    scenario "they see their relationship status" do 
      expect(page).to have_content("Single")
    end
  
    scenario "they see their profile picture" do 
      expect(page).to have_image("eiffel_tower.jpg")
    end

    scenario "they see their account credentials" do 
      click_on "edit account"

      expect(page).to have_field('user_name', with: "somebody")
      expect(page).to have_field('user_email', with: "somebody@example.com")
    end

  end

end