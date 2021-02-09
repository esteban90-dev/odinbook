require "rails_helper"

feature "user receives friend request" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")
    
    sign_in @bob
    visit users_path
    add_friend(@frank)
    sign_out @bob
    sign_in @frank
  end

  scenario "they receive a new notification" do
    visit root_path

    user_sees_new_notification
  end

  scenario "they see 'accept/ignore' links next to the user in the users index" do
    visit users_path

    user_sees_requestor_in_user_index(@bob)
  end

  scenario "they see 'accept/ignore' links next to the requestor in the sent section of the friend requests index" do 
    visit friend_requests_path

    user_sees_requestor_in_friend_request_index(@bob)
  end

end