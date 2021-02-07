require 'rails_helper'

feature "user ignores friend request" do

  before do  
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
    @request = FriendRequest.create(requestor: @bob, requestee: @joe)

    sign_in @joe
    visit friend_requests_path
    ignore_friend_request(@bob)
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Successfully ignored friend request from bob")
  end

  scenario "they aren't friends with the requestor" do 
    expect(@joe.friends).not_to include(@bob)
  end

  scenario "the requestor isn't friends with them" do
    expect(@bob.friends).not_to include(@joe)
  end

  scenario "the friend request no longer exists" do 
    expect{ @request.reload }.to raise_error ActiveRecord::RecordNotFound
  end

end