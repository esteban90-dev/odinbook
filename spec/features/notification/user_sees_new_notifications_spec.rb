require 'rails_helper'

feature "user sees new notifications" do 

  before(:each) do 
    user = FactoryBot.create(:user, :with_profile)
    @notification_1 = user.notifications.create(message: "hello there!")
    @notification_2 = user.notifications.create(message: "goodbye!")

    sign_in user
    visit root_path
  end

  scenario "the 'notifications' link is bold" do
    expect(page).to have_bold_notifications_link
  end

  scenario "the notifications are in descending order" do 
    click_on "notifications" 

    user_sees_content_order_descending(@notification_1.message, @notification_2.message)
  end

  scenario "once viewed, the 'notifications' link is no longer bold" do 
    click_on "notifications" 
    visit root_path

    expect(page).not_to have_bold_notifications_link
  end

  scenario "once viewed, the notifications disappear" do 
    click_on "notifications"
    visit root_path
    click_on "notifications"

    expect(notifications_on_page.count).to eq(0)
  end

end