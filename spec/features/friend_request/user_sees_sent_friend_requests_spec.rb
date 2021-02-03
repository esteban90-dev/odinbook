require "rails_helper"

feature "user sees sent friend requests" do 

  scenario "successfully" do 
    bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")
    request = FriendRequest.create(requestor: bob, requestee: frank)

    sign_in bob
    visit friend_requests_path

    expect(page).to have_sent_friend_request(request)
  end

end
