require 'rails_helper'

def user_sees_profile_picture(picture)
  profile_picture_section = find('.profile-picture')
  expect(profile_picture_section).to have_image(picture)
end

def user_sees_friends_posts_in_desc_order(post_1, post_2)
  expect(page.body.index(post_2) < page.body.index(post_1)).to eq(true)
end

def user_doesnt_see_post_form
  expect(page).not_to have_field("Body")
  expect(page).not_to have_field("Picture")
  expect(page).not_to have_button("create post")
end

def user_sees_profile_information(user)
  about_section = find('.about')
  expect(about_section).to have_content(user.name)
  expect(about_section).to have_content(user.profile.location)
  expect(about_section).to have_content(user.profile.education)
  expect(about_section).to have_content(user.profile.relationship_status)
end


