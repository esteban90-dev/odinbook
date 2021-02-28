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
  expect(requestor_section).to have_accept_ignore_requestor_links(requestor)
end

def user_sees_requestee_addable_in_user_index(requestee)
  requestee_section = find("##{requestee.id}")
  expect(requestee_section).to have_content("#{requestee.name}")
  expect(requestee_section).to have_link("add friend")
end

def user_sees_requestee_pending_in_user_index(requestee)
  requestee_section = find("##{requestee.id}")
  expect(requestee_section).to have_content("#{requestee.name}")
  expect(requestee_section).to have_content("friend request sent")
  expect(requestee_section).to have_no_link
end

def user_sees_requestor_acceptable_ignorable_in_user_index(requestor)
  requestor_section = find("##{requestor.id}")
  expect(requestor_section).to have_content("#{requestor.name}")
  expect(requestor_section).to have_accept_ignore_requestor_links(requestor)
end

def user_sees_requestor_as_friend_in_user_index(requestor)
  requestor_section = find("##{requestor.id}")
  expect(requestor_section).to have_content("#{requestor.name}")
  expect(requestor_section).to have_content("friend")
  expect(requestor_section).to have_no_link
end

def user_sees_incoming_friend_request_notification(requestee)
  request = requestee.incoming_friend_requests.first
  notification_section = find("##{requestee.notifications.last.id}")
  expect(notification_section).to have_content("You have a new friend request from #{request.requestor.name}")
  expect(notification_section).to have_accept_ignore_requestor_links(request.requestor)
end

def user_sees_accepted_friend_request_notification(requestee, requestor)
  notification_section = find("##{requestor.notifications.last.id}")
  expect(notification_section).to have_content("#{requestee.name} accepted your friend request")
  expect(notification_section).to have_link("#{requestee.name}", href: "/users/#{requestee.id}/profile")
end

def have_accept_ignore_requestor_links(requestor)
  have_link("accept", href: "/friend_requests/#{requestor.sent_friend_requests.first.id}/accept")
  have_link("ignore", href: "/friend_requests/#{requestor.sent_friend_requests.first.id}/ignore")
end
