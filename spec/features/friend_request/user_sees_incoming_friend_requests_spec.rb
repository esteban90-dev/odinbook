require "rails_helper"

feature "user sees incoming friend requests" do 

  scenario "successfully" do 

    bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")

    FriendRequest.create(requestor: bob, requestee: frank)
    sign_in frank
    visit friend_requests_path

    expect(contains_incoming_friend_request?(bob)).to eq(true)
  end

end