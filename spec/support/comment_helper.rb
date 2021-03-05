require 'rails_helper'

def comment_on_post(post, new_comment_text)
  post_section = find("##{post.id}")
  within(post_section) do 
    fill_in "comment_body", with: "#{new_comment_text}"
    click_on "comment"
  end
end

def edit_comment(original_comment, new_comment_text)
  comment_section = find("##{original_comment.post.id}").find("##{original_comment.id}")
  within(comment_section) do 
    click_on "edit"
  end
  fill_in "comment_body", with: "#{new_comment_text}"
  click_on "Update Comment"
end

def user_sees_post_comment(post, comment_text)
  post_section = find("##{post.id}")
  expect(post_section).to have_content("#{comment_text}")
end

def user_sees_name_with_comment(comment)
  comment_section = find("##{comment.post.id}").find("##{comment.id}")
  expect(comment_section).to have_link("#{comment.commenter.name}", href: user_profile_path(comment.commenter.id))
end

def post_author_receives_comment_notification(post, comment)
  notification_section = find("##{post.user.notifications.last.id}")
  expect(notification_section).to have_content("#{comment.commenter.name} commented on your post")
  expect(notification_section).to have_link("post", href: user_profile_path(post.user.id) + "##{post.id}")
end