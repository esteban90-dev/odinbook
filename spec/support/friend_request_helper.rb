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
  request = requestor.sent_friend_requests.last
  requestor_section = find(".incoming ##{requestor.id}")
  expect(requestor_section).to have_content("#{requestor.name}")
  expect(requestor_section).to have_accept_ignore_request_links(request)
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
  request = requestor.sent_friend_requests.last
  requestor_section = find("##{requestor.id}")
  expect(requestor_section).to have_content("#{requestor.name}")
  expect(requestor_section).to have_accept_ignore_request_links(request)
end

def user_sees_requestor_as_friend_in_user_index(requestor)
  requestor_section = find("##{requestor.id}")
  expect(requestor_section).to have_content("#{requestor.name}")
  expect(requestor_section).to have_content("friend")
  expect(requestor_section).to have_no_link
end

def user_sees_incoming_friend_request_notification(requestee)
  request = requestee.incoming_friend_requests.last
  notification_section = find("##{requestee.notifications.last.id}")
  expect(notification_section).to have_content("You have a new friend request from #{request.requestor.name}")
  expect(notification_section).to have_accept_ignore_request_links(request)
end

def user_sees_accepted_friend_request_notification(requestor, requestee)
  notification_section = find("##{requestor.notifications.last.id}")
  expect(notification_section).to have_content("#{requestee.name} accepted your friend request")
  expect(notification_section).to have_user_profile_link(requestee)
end

def have_accept_ignore_request_links(request)
  have_link("accept", href: accept_friend_request_path(request)){ |link| link['data-method'] == "delete" }.and(
  have_link("ignore", href: ignore_friend_request_path(request)){ |link| link['data-method'] == "delete" } )
end

def have_user_profile_link(user)
  have_link("#{user.name}", href: user_profile_path(user) )
end


