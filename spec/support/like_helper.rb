require 'rails_helper'

def like(post)
  find("##{post.id}").click_on "like"
end

def unlike(post)
  find("##{post.id}").click_on "unlike"
end

def user_sees_post_with_likes(post, num_likes)
  expect(page).to have_css("##{post.id}", text: "likes: #{num_likes}")
end

def user_sees_post_unlike_button(post)
  post_section = find("##{post.id}")
  expect(post_section).not_to have_link("like", href: post_likes_path(post.id)){ |link| link['data-method'] == "post" }
  expect(post_section).to have_link("unlike", href: like_path(post.likes.first.id)){ |link| link['data-method'] == "delete" }
end

def user_sees_post_like_button(post)
  post_section = find("##{post.id}")
  expect(post_section).not_to have_link("unlike")
  expect(post_section).to have_link("like", href: post_likes_path(post.id)){ |link| link['data-method'] == "post" }
end

def user_sees_post_like_notification(user, post)
  notification_section = find("##{post.user.notifications.last.id}")
  expect(notification_section).to have_content("#{user.name} liked your")
  expect(notification_section).to have_link("post", href: user_profile_path(post.user.id) + "##{post.id}")
end

