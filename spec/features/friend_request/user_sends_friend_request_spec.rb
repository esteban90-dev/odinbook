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
    visit root_path

    click_on "users"

    user_sees_requestee_in_user_index(@joe)
  end

  scenario "they see the requestee appear in the sent section of the friend requests index" do 
    visit root_path

    click_on "profile"
    click_on "friend requests"

    user_sees_requestee_in_friend_request_index(@joe)
  end

end