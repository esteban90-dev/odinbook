require 'rails_helper'

feature "requestee ignores friend request" do

  context "from the friend requests index" do

    before(:each) do  
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
      @friend_request = FriendRequest.create(requestor: @bob, requestee: @joe)

      sign_in @joe
      visit root_path
      click_on "joe"
      click_on "friend requests"

      ignore_from_friend_requests(@friend_request)
    end

    scenario "and sees a flash message" do 
      expect(page).to have_content("Successfully ignored friend request")
    end

    scenario "and doesn't see the requestor in their friends list" do 
      click_on "joe"
      click_on "friends"

      expect(page).not_to have_content("bob")
    end

    scenario "and no longer sees pending incoming friend requests" do 
      click_on "joe"
      click_on "friend requests"

      expect(incoming_friend_requests.count).to eq(0)
    end

    scenario "the requestor doesn't see the requestee in their friends list" do
      sign_out @joe
      sign_in @bob

      visit root_path
      click_on "bob"
      click_on "friends"

      expect(page).not_to have_content("joe")
    end

    scenario "the requestor sees the requestee as addable in the users index" do 
      sign_out @joe
      sign_in @bob

      visit root_path
      click_on "users"

      expect(page).to have_user_appear_addable(@joe)
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

  context "from a friend request notification" do

    before(:each) do  
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")

      sign_in @bob
      visit root_path
      click_on "users"
      add_friend(@joe)
      sign_out @bob

      sign_in @joe
      visit root_path
      click_on "notifications"

      ignore_from_notifications(@joe.notifications.first)
    end

    scenario "and sees a flash message" do 
      expect(page).to have_content("Successfully ignored friend request")
    end

    scenario "and doesn't see the requestor in their friends list" do 
      click_on "joe"
      click_on "friends"

      expect(page).not_to have_content("bob")
    end

    scenario "and no longer sees pending incoming friend requests" do 
      click_on "joe"
      click_on "friend requests"

      expect(incoming_friend_requests.count).to eq(0)
    end

    scenario "the requestor doesn't see the requestee in their friends list" do
      sign_out @joe
      sign_in @bob

      visit root_path
      click_on "bob"
      click_on "friends"

      expect(page).not_to have_content("joe")
    end

    scenario "the requestor sees the requestee as addable in the users index" do 
      sign_out @joe
      sign_in @bob

      visit root_path
      click_on "users"

      expect(page).to have_user_appear_addable(@joe)
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

  context "from the users index" do

    before(:each) do  
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
      @friend_request = FriendRequest.create(requestor: @bob, requestee: @joe)

      sign_in @joe
      visit root_path
      click_on "users"

      ignore_from_users(@bob)
    end

    scenario "and sees a flash message" do 
      expect(page).to have_content("Successfully ignored friend request")
    end

    scenario "and doesn't see the requestor in their friends list" do 
      click_on "joe"
      click_on "friends"

      expect(page).not_to have_content("bob")
    end

    scenario "and no longer sees pending incoming friend requests" do 
      click_on "joe"
      click_on "friend requests"

      expect(incoming_friend_requests.count).to eq(0)
    end

    scenario "the requestor doesn't see the requestee in their friends list" do
      sign_out @joe
      sign_in @bob

      visit root_path
      click_on "bob"
      click_on "friends"

      expect(page).not_to have_content("joe")
    end

    scenario "the requestor sees the requestee as addable in the users index" do 
      sign_out @joe
      sign_in @bob

      visit root_path
      click_on "users"

      expect(page).to have_user_appear_addable(@joe)
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

end