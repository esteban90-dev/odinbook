require 'rails_helper'

feature "user ignores friend request" do

  scenario "successfully" do 
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
    FriendRequest.create(requestor: bob, requestee: joe)

    sign_in joe
    visit friend_requests_path
    ignore_friend_request(bob)

    expect(page).to have_content("Successfully ignored friend request from bob")
    expect(joe.friends).not_to include(bob)
    expect(bob.friends).not_to include(joe)
    expect(FriendRequest.all.any?).to eq(false)
  end

end