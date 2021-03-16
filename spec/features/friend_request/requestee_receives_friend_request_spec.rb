require "rails_helper"

feature "requestee receives friend request" do 

  scenario "and sees a new notification" do 
    bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")
    
    sign_in bob
    visit root_path
    click_on "users"
    find("##{frank.id}", text: "frank").click_on "add friend"
    sign_out bob

    sign_in frank
    visit root_path
    click_on "notifications"

    expect(page).to have_content("You have a new friend request from bob")
  end

end