require 'rails_helper'

def user_doesnt_see_post_form
  expect(page).not_to have_field("Body")
  expect(page).not_to have_field("Picture")
  expect(page).not_to have_button("Create Post")
end

def user_doesnt_see_comment_form
  expect(page).not_to have_field("Body")
  expect(page).not_to have_button("Create Comment")
end

def edit_profile_selector
  '[data-test="edit-profile"]'
end