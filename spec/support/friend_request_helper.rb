require 'rails_helper'

def click_add_friend(user)
  within("##{user.id}") do 
    click_on "Add friend"
  end
end

def accept_friend_request(user)
  within(".incoming") do
    within("##{user.id}") do
      click_on "Accept"
    end
  end
end

def ignore_friend_request(user)
  within(".incoming") do
    within("##{user.id}") do
      click_on "Ignore"
    end
  end
end

def request_pending?(user)
  user_section = find("##{user.id}")
  expect(user_section).to have_no_link("Add friend").and have_content("Request Pending")
end

def page_has_incoming_friend_request?(requestor)
  incoming_section = find('.incoming')
  expect(incoming_section).to have_content(requestor.name)
end

def page_has_sent_friend_request?(requestee)
  sent_section = find('.sent')
  expect(sent_section).to have_content(requestee.name)
end