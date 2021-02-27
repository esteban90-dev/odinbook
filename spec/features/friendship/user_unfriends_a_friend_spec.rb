require 'rails_helper'

feature "user unfriends a friend" do 

  before(:each) do 
    @joe = FactoryBot.create(:user, name: "joe", email: "joe@mail.com")
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    @joe.friends << @bob

    sign_in @bob
    visit root_path
    click_on "bob"
    click_on "friends"
    unfriend(@joe)
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Successfully unfriended joe")
  end

  scenario "they don't see the other user in their friends list" do
    visit root_path
    click_on "bob"
    click_on "friends"

    expect(page).not_to have_content("joe")
  end

  scenario "the other user doesn't see the user that unfriended them in their friends list" do 
    sign_out @bob
    sign_in @joe
    visit root_path
    click_on "joe"
    click_on "friends"

    expect(page).not_to have_content("bob")
  end

end