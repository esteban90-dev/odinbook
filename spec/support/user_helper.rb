require 'rails_helper'

def have_user(user)
  have_css("[data-test=user-#{user.id}]", text: user.name)
end

def have_user_appear_addable(user)
  have_css(add_friend_selector)
end

def have_user_appear_as_friend(user)
  have_css("[data-test=user-#{user.id}]", text: user.name).and have_css("[data-test=user-#{user.id}]", text: "friends")
end

def have_user_appear_pending(user)
  have_css("[data-test=user-#{user.id}]", text: "friend request sent")
end