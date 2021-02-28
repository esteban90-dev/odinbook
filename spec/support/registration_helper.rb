require 'rails_helper'

def user_sees_edit_profile_notification
  expect(page).to have_content("Welcome to Odinbook!")
  expect(page).to have_link("Click here", href: edit_user_profile_path(User.first.id))
  expect(page).to have_content("to edit your profile.")
end