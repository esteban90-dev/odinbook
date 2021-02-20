require 'rails_helper'

feature "user ignores friend request" do

  before do  
    @bob = FactoryBot.create(:user, :with_blank_profile, name: "bob", email: "bob@example.com")
    @joe = FactoryBot.create(:user, :with_blank_profile, name: "joe", email: "joe@example.com")
    FriendRequest.create(requestor: @bob, requestee: @joe)

    sign_in @joe
    visit root_path
    click_on "joe"
    click_on "friend requests"
    ignore_friend_request(@bob)
  end

  scenario "user sees a flash message" do 
    expect(page).to have_content("Successfully ignored friend request from bob")
  end

  scenario "user doesn't see requestor in their friends list" do 
    click_on "joe"
    click_on "friends"

    expect(page).not_to have_content("bob")
  end

  scenario "the requestor doesn't see the requestee in their friends list" do
    sign_out @joe
    sign_in @bob

    visit root_path
    click_on "bob"
    click_on "friends"

    expect(page).not_to have_content("joe")
  end

  scenario "the friend request no longer exists" do 
    expect(FriendRequest.all.any?).to eq(false)
  end

  scenario "the requestor sees the requestee as addable in the users index" do 
    sign_out @joe
    sign_in @bob

    visit root_path
    click_on "users"

    user_sees_requestee_addable_in_user_index(@joe)
  end

end