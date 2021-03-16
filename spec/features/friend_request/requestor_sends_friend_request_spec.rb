require 'rails_helper'

feature "requestor sends friend request" do

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")

    sign_in @bob
    visit root_path
    click_on "users"
    find("[data-test=user-#{@joe.id}]", text: @joe.name).click_on "add friend"
  end

  scenario "and sees a flash message" do
    expect(page).to have_content("Friend request successfully sent")
  end

  scenario "and sees 'friend request sent' next to the requestee in the users index" do 
    within("[data-test=user-#{@joe.id}]", text: @joe.name) do 
      expect(page).to have_content("friend request sent")
    end
  end

  scenario "and sees the requestee appear in the sent section of the friend requests index" do 
    click_on "bob"
    click_on "friend requests"
 
    within('.sent') do 
      expect(page).to have_css("[data-test=user-#{@joe.id}]", text: @joe.name)
    end
  end

end