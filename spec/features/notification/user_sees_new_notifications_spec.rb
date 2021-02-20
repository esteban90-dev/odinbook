require 'rails_helper'

feature "user sees new notifications" do 

  before(:each) do 
    user = FactoryBot.create(:user, :with_blank_profile)
    @notification_1 = user.notifications.create(message: "hello there!")
    @notification_2 = user.notifications.create(message: "goodbye!")

    sign_in user
    visit root_path
  end

  scenario "the 'notifications' link is bold" do
    user_sees_notifications_link_bold
  end

  scenario "the notifications are in descending order" do 
    click_on "notifications" 

    user_sees_notifications_in_desc_order(@notification_1.message, @notification_2.message)
  end

  scenario "once viewed, the 'notifications' link is no longer bold" do 
    click_on "notifications" 
    visit root_path

    user_sees_notifications_link_not_bold
  end

end