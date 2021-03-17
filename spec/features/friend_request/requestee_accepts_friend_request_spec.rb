require 'rails_helper'

feature "requestee accepts friend request" do

  before(:each) do
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
    @friend_request = FriendRequest.create(requestor: @bob, requestee: @joe)

    sign_in @joe
    visit root_path
    click_on "joe"
    click_on "friend requests"
  
    accept(@friend_request)
  end

  scenario "and sees a flash message" do
    expect(page).to have_content("You and bob are now friends")
  end

  scenario "and sees the requestor appear in their friends list" do 
    click_on "joe"
    click_on "friends"

    expect(page).to have_content("bob")
  end

  scenario "and sees the requestor appear in the user index as a friend" do 
    click_on "users"

    expect(page).to have_user_appear_as_friend(@bob)
  end

  scenario "and no longer sees incoming friend requests" do 
    click_on "joe"
    click_on "friend requests"

    expect(incoming_friend_requests.count).to eq(0)
  end

  scenario "the requestor receives a new notification" do 
    sign_out @joe
    sign_in @bob

    visit root_path
    click_on "notifications"

    expect(page).to have_content("joe accepted your friend request")
  end

  scenario "the requestor sees the requestee in their friends list" do
    sign_out @joe
    sign_in @bob

    visit root_path
    click_on "bob"
    click_on "friends"

    expect(page).to have_content("joe")
  end

  scenario "the requestor no longer sees pending sent friend requests" do 
    sign_out @joe
    sign_in @bob

    visit root_path
    click_on "bob"
    click_on "friend requests"

    expect(sent_friend_requests.count).to eq(0)
  end

end