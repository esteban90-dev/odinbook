require 'rails_helper'

def have_user(user)
  have_css("##{user.id}", text: user.name)
end

def user_appears_pending?(user)
  user_section = find("##{user.id}")
  expect(user_section).to have_no_link("Add friend").and have_content("friend request sent")
end

def user_appears_acceptable?(user)
  user_section = find("##{user.id}")
  expect(user_section).to have_link("accept")
end