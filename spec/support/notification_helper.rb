require 'rails_helper'

def user_sees_notifications_in_desc_order(notification_1, notification_2)
  expect(page.body.index(notification_2) < page.body.index(notification_1)).to eq(true)
end

def user_sees_notifications_link_bold
  expect(page).to have_selector('b', text: 'notifications')
end

def user_sees_notifications_link_not_bold
  expect(page).not_to have_selector('b', text: 'notifications')
end