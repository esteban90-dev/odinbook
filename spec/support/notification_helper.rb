require 'rails_helper'

def have_new_notification
  have_css(".nav", text: "new notification")
end