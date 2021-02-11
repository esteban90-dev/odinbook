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

def user_sees_new_notification(notification)
  expect(page).to have_css(".nav", text: "#{notification}")
end

def user_sees_requestee_in_friend_request_index(requestee)
  requestee_section = find(".sent ##{requestee.id}")
  expect(requestee_section).to have_content("#{requestee.name}")
  expect(requestee_section).to have_no_link
end

def user_sees_requestor_in_friend_request_index(requestor)
  requestor_section = find(".incoming ##{requestor.id}")
  expect(requestor_section).to have_content("#{requestor.name}")
  expect(requestor_section).to have_link("accept", href: "/friend_requests/#{requestor.sent_friend_requests.first.id}/accept")
  expect(requestor_section).to have_link("ignore", href: "/friend_requests/#{requestor.sent_friend_requests.first.id}/ignore")
end

def user_sees_requestee_in_user_index(requestee)
  requestee_section = find("##{requestee.id}")
  expect(requestee_section).to have_content("#{requestee.name}")
  expect(requestee_section).to have_content("friend request sent")
  expect(requestee_section).to have_no_link
end

def user_sees_requestor_in_user_index(requestor)
  requestor_section = find("##{requestor.id}")
  expect(requestor_section).to have_content("#{requestor.name}")
  expect(requestor_section).to have_link("accept", href: "/friend_requests/#{requestor.sent_friend_requests.first.id}/accept")
  expect(requestor_section).to have_link("ignore", href: "/friend_requests/#{requestor.sent_friend_requests.first.id}/ignore")
end
