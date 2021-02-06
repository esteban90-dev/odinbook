require 'rails_helper'

def add_friend(user)
  find("##{user.id}", text: user.name).click_on "Add"
end

def accept_friend_request(user)
  find("##{user.id}", text: user.name).click_on "Accept"
end

def ignore_friend_request(user)
  find("##{user.id}", text: user.name).click_on "Ignore"
end

def have_incoming_friend_request(request)
  have_css(".incoming", text: request.requestor.name)
end

def have_sent_friend_request(user)
  have_css(".sent", text: user.name)
end