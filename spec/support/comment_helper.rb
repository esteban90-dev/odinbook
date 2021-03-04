require 'rails_helper'

def comment_on_post(post, comment)
  post_section = find("##{post.id}")
  within(post_section) do 
    fill_in "comment_body", with: "#{comment}"
    click_on "comment"
  end
end

def user_sees_post_comment(comment)
  comment_section = find("##{comment.post.id}").find("##{comment.id}")
  expect(comment_section).to have_content("#{comment.body}")
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