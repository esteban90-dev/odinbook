require 'rails_helper'

feature "requestee accepts friend request" do

  before(:each) do
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
    FriendRequest.create(requestor: @bob, requestee: @joe)

    sign_in @joe
    visit root_path
    click_on "joe"
    click_on "friend requests"
  
    find("[data-test=user-#{@bob.id}]", text: @bob.name).click_on "accept"
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

    within("[data-test=user-#{@bob.id}]", text: @bob.name) do 
      expect(page).to have_content("friends")
    end
  end

  scenario "and no longer sees pending incoming friend requests" do 
    click_on "joe"
    click_on "friend requests"

    within('.incoming') do 
      expect(page).not_to have_content("accept")
      expect(page).not_to have_content("ignore")
    end
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

    within('.sent') do 
      expect(page).not_to have_content("pending")
    end
  end

end