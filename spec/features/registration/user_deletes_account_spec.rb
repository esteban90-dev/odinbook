require 'rails_helper'

feature "user deletes account" do

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    sign_in @bob

    visit root_path
    click_on "edit account"
    click_on "Cancel my account"
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Your account has been successfully cancelled")
  end
    
  scenario "other users no longer see them in the users index" do 
    sign_out @bob
    sign_in @frank

    visit root_path
    click_on "users"

    expect(page).not_to have_content("bob")
  end

end