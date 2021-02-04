require 'rails_helper'

feature "user receives notification" do 

  scenario "when a new friend request is receieved" do 
    frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")
    bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    
    sign_in frank
    visit users_path
    add_friend(bob)
    sign_out frank
    sign_in bob
    visit root_path

    expect(page).to have_new_notification
  end

end