require 'rails_helper'

feature "requestee accepts friend request" do

  context "from the friend requests index" do 

    before(:each) do
      @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
      @joe = FactoryBot.create(:user, :with_profile, name: "joe", email: "joe@example.com")
      
      sign_in @bob
      visit root_path
      click_on "users"
      add_friend(@joe)
      sign_out @bob

      sign_in @joe
      visit root_path
      click_on "joe"
      click_on "friend requests"
    
      accept_from_friend_requests(@joe.incoming_friend_requests.first)
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

  context "from a friend request notification" do 

    before(:each) do
      @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
      @joe = FactoryBot.create(:user, :with_profile, name: "joe", email: "joe@example.com")
      
      sign_in @bob
      visit root_path
      click_on "users"
      add_friend(@joe)
      sign_out @bob

      sign_in @joe
      visit root_path
      click_on "joe"
      click_on "notifications"
    
      accept_from_notifications(@joe.notifications.first)
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

  context "from the users index" do 

    before(:each) do
      @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
      @joe = FactoryBot.create(:user, :with_profile, name: "joe", email: "joe@example.com")
      FriendRequest.create(requestor: @bob, requestee: @joe)

      sign_in @joe
      visit root_path
      click_on "users"
    
      accept_from_users(@bob)
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

end
