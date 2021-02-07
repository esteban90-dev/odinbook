require 'rails_helper'

feature "user sends friend request" do

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")

    sign_in @bob
    visit users_path 
    add_friend(@joe)
  end

  scenario "they see a flash message" do
    expect(page).to have_content("Friend request successfully sent to joe")
  end

  scenario "they see 'friend request sent' next to the requestee in the users index" do 
    user_sees_requestee_pending_in_user_index(@joe)
  end

  scenario "they see it appear in the sent section of the friend requests index" do 
    @request = FriendRequest.first

    visit friend_requests_path

    user_sees_sent_friend_request(@request)
  end

end