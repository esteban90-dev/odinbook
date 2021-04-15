require "rails_helper"

feature "user edits profile" do 

  context "with valid data" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@mail.com" )
      sign_in @bob
      
      visit root_path
      click_on "bob"
      click_on "edit profile"
      fill_in "Location", with: "China"
      select("Master's Degree", from: "Education")
      select('Married', from: "Relationship Status")
      attach_file "Picture", "#{Rails.root}/spec/files/eiffel_tower.jpg"

      click_on "Save Profile"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully updated profile")
    end

    scenario "they see their location" do 
      expect(page).to have_content("China")
    end

    scenario "they see their education" do 
      expect(page).to have_content("Master's Degree")
    end

    scenario "they see their relationship status" do 
      expect(page).to have_content("Married")
    end

    scenario "they see their profile picture" do 
      expect(page).to have_image("eiffel_tower.jpg")
    end

  end

  context "without a location" do 

    scenario "they see an error message" do 
      @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@mail.com" )
      sign_in @bob
      
      visit root_path
      click_on "bob"
      click_on "edit profile"
      fill_in "Location", with: ""
      select("Master's Degree", from: "Education")
      select('Married', from: "Relationship Status")
      attach_file "Picture", "#{Rails.root}/spec/files/eiffel_tower.jpg"
      click_on "Save Profile"

      expect(page).to have_content("can't be blank")
    end

  end

end