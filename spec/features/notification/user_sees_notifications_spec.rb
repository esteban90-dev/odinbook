require 'rails_helper'

feature "user sees notifications" do 

  scenario "in descending order" do 
    user = FactoryBot.create(:user)
    notification_1 = user.notifications.create(message: "hello there!")
    notification_2 = user.notifications.create(message: "goodbye!")

    sign_in user
    visit root_path
    click_on "new notifications" 

    expect(notifications_descending?(notification_1, notification_2)).to eq(true)
    expect(page).not_to have_content("new notifications")
  end

end