require 'rails_helper'

def add_friend(user)
  find("##{user.id}", text: user.name).click_on "add friend"
end

def accept_friend_request(user)
  find("##{user.id}", text: user.name).click_on "accept"
end

def ignore_friend_request(user)
  find("##{user.id}", text: user.name).click_on "ignore"
end

def have_incoming_friend_request(request)
  have_css(".incoming", text: request.requestor.name)
end

def user_sees_new_notification
  expect(page).to have_css(".nav", text: "new notification")
end

def user_sees_requestee_in_friend_request_index(requestee)
  user_section = find(".sent ##{requestee.id}")
  expect(user_section).to have_content("#{requestee.name}")
  expect(user_section).to have_no_link
end

def user_sees_requestor_in_friend_request_index(requestor)
  user_section = find(".incoming ##{requestor.id}")
  expect(user_section).to have_content("#{requestor.name}")
  expect(user_section).to have_link("accept")
  expect(user_section).to have_link("ignore")
end

def user_sees_requestee_in_user_index(user)
  user_section = find("##{user.id}")
  expect(user_section).to have_content("#{user.name}")
  expect(user_section).to have_content("friend request sent")
  expect(user_section).to have_no_link
end

def user_sees_requestor_in_user_index(user)
  user_section = find("##{user.id}")
  expect(user_section).to have_content("#{user.name}")
  expect(user_section).to have_link("accept")
  expect(user_section).to have_link("ignore")
end
