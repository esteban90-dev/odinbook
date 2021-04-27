require "rails_helper"

feature "user edits profile" do 

  context "with valid data" do 
    before(:each) do
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      
      sign_in bob
      visit root_path
      find(nav_section).click_on("bob")
      find(edit_profile_selector).click
      fill_in "Location", with: "New York"
      select("Master's Degree", from: "Education")
      select('Single', from: "Relationship Status")
      attach_file "Picture", "#{Rails.root}/spec/files/eiffel_tower.jpg"

      click_on "Save Profile"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully updated profile")
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

  end

  context "without a location" do 

    scenario "they see an error message" do 
      visit root_path

      click_on "sign up"
      fill_in "Name", with: "somebody"
      fill_in "Email", with: "somebody@example.com"
      fill_in "Password", with: "testpassword"
      fill_in "Password confirmation", with: "testpassword"
      click_on "Sign up"
      fill_in "Location", with: " "
      select("Master's Degree", from: "Education")
      select('Single', from: "Relationship Status")
      attach_file "Picture", "#{Rails.root}/spec/files/eiffel_tower.jpg"
      click_on "Save Profile"

      expect(page).to have_content("can't be blank")
    end

  end

  context "without a profile picture" do 

    scenario "they see a generic profile picture uploaded for them" do 
      visit root_path

      click_on "sign up"
      fill_in "Name", with: "somebody"
      fill_in "Email", with: "somebody@example.com"
      fill_in "Password", with: "testpassword"
      fill_in "Password confirmation", with: "testpassword"
      click_on "Sign up"
      fill_in "Location", with: "somewhere"
      select("Master's Degree", from: "Education")
      select('Single', from: "Relationship Status")
      click_on "Save Profile"

      #filename of default profile picture varies on each upload, so just check for presence of image
      expect(page_has_any_image?).to eq(true)
    end

  end

  context "with a text file instead of a picture" do 

    scenario "they see an error message" do 
      visit root_path

      click_on "sign up"
      fill_in "Name", with: "somebody"
      fill_in "Email", with: "somebody@example.com"
      fill_in "Password", with: "testpassword"
      fill_in "Password confirmation", with: "testpassword"
      click_on "Sign up"
      fill_in "Location", with: ""
      select("Master's Degree", from: "Education")
      select('Single', from: "Relationship Status")
      attach_file "Picture", "#{Rails.root}/spec/files/test.txt"
      click_on "Save Profile"

      expect(page).to have_content("not a valid file format")
    end

  end

end