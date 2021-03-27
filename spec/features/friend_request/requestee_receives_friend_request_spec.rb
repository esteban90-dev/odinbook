require "rails_helper"

feature "requestee receives friend request" do 

  scenario "and sees a new notification" do 
    bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@mail.com")
    frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@mail.com")
    
    sign_in bob
    visit root_path
    click_on "users"
    add_friend(frank)
    sign_out bob

    sign_in frank
    visit root_path
    click_on "notifications"

    expect(page).to have_content("You have a new friend request from bob")
  end

end