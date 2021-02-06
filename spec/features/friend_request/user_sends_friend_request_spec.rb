require 'rails_helper'

feature "user sends friend request" do

  before do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")

    sign_in @bob
    visit users_path 
    add_friend(@joe)
  end

  scenario "and sees a flash message" do
    expect(page).to have_content("Friend request successfully sent to joe")
  end

  scenario "and sees 'friend request sent' next to the user in the users index" do 
    expect(user_appears_pending?(@joe)).to be(true)
  end

  scenario "and sees it appear in the sent section of the friend requests index" do 
    visit friend_requests_path

    expect(page).to have_sent_friend_request(@joe)
  end

end