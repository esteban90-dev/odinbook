require 'rails_helper'

def have_bold_notifications_link
  have_css('b', text: 'notifications')
end

def user_sees_notifications_descending(notification_1, notification_2)
  expect(page.body.index(@notification_2.message) < page.body.index(@notification_1.message)).to eq(true)
end

def notifications_on_page
  all(:xpath, '//div[@data-test]'){ |element| element['data-test'].include?('notification') }
end