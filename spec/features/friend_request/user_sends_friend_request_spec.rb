require 'rails_helper'

feature "user sends friend request" do

  scenario "successfully" do
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")

    sign_in bob
    visit users_path 
    add_friend(joe)

    expect(page).to have_content("Friend request successfully sent to joe")
    expect(request_pending?(joe)).to eq(true)
  end

end