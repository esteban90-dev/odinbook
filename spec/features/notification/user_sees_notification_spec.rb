require 'rails_helper'

feature "user sees notification" do 

  scenario "successfully" do 

    user = FactoryBot.create(:user)
    user.notifications.create(message: "hello there!")

    sign_in user
    visit root_path
    click_on "new notifications" 

    expect(page).to have_content("hello there!")
    expect(page).not_to have_content("new notifications")
  end

end