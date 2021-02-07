require 'rails_helper'

feature "user receives notification" do 

  scenario "when a sent friend request is accepted" do 
    frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")
    bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    
    sign_in frank
    visit users_path
    add_friend(bob)
    sign_out frank

    sign_in bob
    visit friend_requests_path
    accept_friend_request(frank)
    sign_out bob
    
    sign_in frank
    visit root_path

    expect(page).to have_new_notification
  end

end