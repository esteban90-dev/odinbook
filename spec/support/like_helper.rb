require 'rails_helper'

def like(post)
  find(like_post_selector).click
end

def unlike(post)
  find(unlike_post_selector).click
end

def click_post_link_in_notification(notification)
  find("[data-test=notification-#{notification.id}]").click_on "post"
end

def have_post_with_likes(post, num_likes)
  have_css("[data-test=post-#{post.id}]", text: "likes: #{num_likes}")
end

def user_sees_post_like_button(post)
  within("[data-test=post-#{post.id}]") do 
    expect(page).to have_css(like_post_selector)
  end
end

def user_doesnt_see_post_like_button(post)
  within("[data-test=post-#{post.id}]") do 
    expect(page).not_to have_css(like_post_selector)
  end
end

def user_sees_post_unlike_button(post)
  within("[data-test=post-#{post.id}]") do 
    expect(page).to have_css(unlike_post_selector)
  end
end

def user_doesnt_see_post_unlike_button(post)
  within("[data-test=post-#{post.id}]") do 
    expect(page).not_to have_css(unlike_post_selector)
  end
end

def like_post_selector
  '[data-test="like-post"]'
end

def unlike_post_selector
  '[data-test="unlike-post"]'
end
