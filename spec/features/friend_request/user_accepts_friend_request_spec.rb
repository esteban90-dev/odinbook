require 'rails_helper'

feature "user accepts friend request" do

  before(:each) do
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
    FriendRequest.create(requestor: @bob, requestee: @joe)

    sign_in @joe
    visit root_path
    click_on "joe"
    click_on "friend requests"
    accept_friend_request(@bob)
  end

  scenario "user sees a flash message" do
    expect(page).to have_content("Successfully accepted friend request from bob")
  end

  scenario "user sees the requestor appear in their friends list" do 
    click_on "joe"
    click_on "friends"

    expect(page).to have_content("bob")
  end

  scenario "user sees the requestor appear in the user index as a friend" do 
    click_on "users"

    user_sees_requestor_as_friend_in_user_index(@bob)
  end

  scenario "the requestor receives a new notification" do 
    sign_out @joe
    sign_in @bob

    visit root_path
    click_on "notifications"

    expect(page).to have_content("joe accepted your friend request")
  end

  scenario "the requestor sees the user in their friends list" do
    sign_out @joe
    sign_in @bob

    visit root_path
    click_on "bob"
    click_on "friends"

    expect(page).to have_content("joe")
  end

  scenario "the friend request no longer exists" do 
    expect(FriendRequest.all.any?).to eq(false)
  end

end