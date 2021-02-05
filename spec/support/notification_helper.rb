require 'rails_helper'

def have_new_notification
  have_css(".nav", text: "new notification")
end

def notifications_descending?(notification_1, notification_2)
  page.body.index(notification_2.message) < page.body.index(notification_1.message)
end