require 'rails_helper'

def user_sees_create_profile_notification
  expect(page).to have_content("Welcome to Odinbook!")
  expect(page).to have_link("Click here", href: "/users/#{User.first.id}/profile/edit")
  expect(page).to have_content("to edit your profile.")
end