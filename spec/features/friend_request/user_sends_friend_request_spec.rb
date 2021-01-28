require 'rails_helper'

feature "user sends friend request" do

  scenario "successfully" do
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")

    sign_in bob
    visit users_path 

    click_add_friend(joe)

    expect(page).to have_content("Friend request successfully sent to joe")
    expect(joe.incoming_friend_requests.first.requestor.name).to eq("bob")
  end

end