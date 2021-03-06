require 'rails_helper'

def comment_on_post(post, comment_text)
  within("[data-test=post-#{post.id}]") do 
    fill_in "comment_body", with: comment_text
    click_on "Create Comment"
  end
end

def have_commenter_name(comment, user_name)
  have_css("[data-test=comment-#{comment.id}]", text: user_name)
end

def click_on_comment_user_name(comment)
  find("[data-test=comment-#{comment.id}]").click_on comment.commenter.name
end

def delete_comment(comment)
  find(delete_comment_selector).click
end

def edit_comment(comment, new_comment_text)
  find(edit_comment_selector).click
  fill_in "comment_body", with: new_comment_text
  click_on "Update Comment"
end

def comment_doesnt_appear_editable(comment)
  within("[data-test=comment-#{comment.id}]") do 
    expect(page).not_to have_link("edit")
  end
end

def comment_doesnt_appear_deletable(comment)
  within("[data-test=comment-#{comment.id}]") do 
    expect(page).not_to have_link("delete")
  end
end

def edit_comment_selector
  '[data-test="edit-comment"]'
end

def delete_comment_selector
  '[data-test="delete-comment"]'
end