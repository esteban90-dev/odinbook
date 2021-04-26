require 'rails_helper'

feature "requestor sends friend request" do

  context "from the users index" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")

      sign_in @bob
      visit root_path
      click_on "users"
      find(add_friend_selector).click
    end

    scenario "and sees a flash message" do
      expect(page).to have_content("Friend request successfully sent")
    end

    scenario "and sees 'friend request sent' next to the requestee in the users index" do 
      user_appears_pending(@joe)
    end

    scenario "and sees 'friend request sent' next to the requestee in the friend requests index" do 
      click_on "bob"
      click_on "friend requests"
  
      user_appears_pending(@joe)
    end

    scenario "and sees 'friend request sent' on the requestee's profile" do 
      click_on "joe"
      
      user_appears_pending(@joe)
    end

  end

  context "from a non friend's profile" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")

      sign_in @bob
      visit root_path
      click_on "users"
      click_on "joe"
      find(add_friend_selector).click
    end

    scenario "and sees a flash message" do
      expect(page).to have_content("Friend request successfully sent")
    end

    scenario "and sees 'friend request sent' next to the requestee in the users index" do 
      user_appears_pending(@joe)
    end

    scenario "and sees 'friend request sent' next to the requestee in the friend requests index" do 
      click_on "bob"
      click_on "friend requests"
  
      user_appears_pending(@joe)
    end
    
    scenario "and sees 'friend request sent' on the requestee's profile" do 
      click_on "joe"
      
      user_appears_pending(@joe)
    end

  end

end