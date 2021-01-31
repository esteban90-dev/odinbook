require 'rails_helper'

feature "user unfriends a friend" do 

  scenario "successfully" do 
    joe = FactoryBot.create(:user, name: "joe", email: "joe@mail.com")
    bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    joe.friends << bob

    sign_in bob
    visit friendships_path
    unfriend(joe)

    expect(page).to have_content("Successfully unfriended joe")
    expect(bob.friends).not_to include(joe)
    expect(Friendship.all.any?).to eq(false)
  end

end