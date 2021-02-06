require "rails_helper"

feature "user receives friend request" do 

  before do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")
    @request = FriendRequest.create(requestor: @bob, requestee: @frank)

    sign_in @frank
  end

  scenario "they see it appear in the sent section of the friend requests index" do 
    visit friend_requests_path

    expect(page).to have_incoming_friend_request(@request)
  end

  scenario "they see an 'accept' link next to the user in the users index" do
    visit users_path

    expect(user_appears_acceptable?(@bob)).to eq(true)
  end

end