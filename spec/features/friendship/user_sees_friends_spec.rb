require 'rails_helper'

feature "user sees friends" do

  scenario "successfully" do 
    joe = FactoryBot.create(:user, name: "joe", email: "joe@mail.com")
    bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    joe.friends << bob

    sign_in joe
    visit friendships_path

    expect(page).to have_content("bob")
  end

end