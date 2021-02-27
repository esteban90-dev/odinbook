require "rails_helper"

feature "user edits profile" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com" )
    sign_in @bob
    
    visit root_path
    click_on "bob"
    click_on "edit profile"
    fill_in "Location", with: "New York"
    select("Master's Degree", from: "Education")
    select('Single', from: "Relationship Status")
    attach_file "Picture", "#{Rails.root}/spec/files/eiffel_tower.jpg"

    click_on "save"
  end

  scenario "they receive a flash message" do 
    expect(page).to have_content("Successfully updated profile")
  end

  scenario "they see their updated profile information" do 
    user_sees_profile_information(@bob.reload)
  end

  scenario "they see their profile picture" do 
    user_sees_profile_picture("eiffel_tower.jpg")
  end

end