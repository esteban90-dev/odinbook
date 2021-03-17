require 'rails_helper'

def comment_on_post(post, comment_text)
  within("[data-test=post-#{post.id}]") do 
    fill_in "comment_body", with: comment_text
    click_on "comment"
  end
end

def have_commenter_name(comment, user_name)
  have_css("[data-test=comment-#{comment.id}]", text: user_name)
end

def click_on_comment_user_name(comment)
  find("[data-test=comment-#{comment.id}]").click_on comment.commenter.name
end

def delete_comment(comment)
  find("[data-test=comment-#{comment.id}]").click_on "delete"
end

def edit_comment(comment, new_comment_text)
  find("[data-test=comment-#{@comment.id}]").click_on "edit"
  fill_in "comment_body", with: new_comment_text
  click_on "Update Comment"
end