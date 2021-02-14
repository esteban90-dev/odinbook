require "rails_helper"

feature "user edits profile" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    @bob.create_profile({})
    sign_in @bob
    
    visit root_path
    click_on "bob"
    click_on "edit profile"
    fill_in "Location", with: "New York"
    select("Master's Degree", from: "Education")
    select('Single', from: "Relationship Status")

    click_on "save"
  end

  scenario "they receive a flash message" do 
    expect(page).to have_content("Successfully updated profile")
  end

  scenario "they see their updated profile information" do 
    expect(page).to have_content("New York")
    expect(page).to have_content("Master's Degree")
    expect(page).to have_content("Single")
  end

end