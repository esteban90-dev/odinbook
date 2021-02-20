require 'rails_helper'

def user_sees_profile_picture(picture)
  profile_picture_section = find('.profile-picture')
  expect(profile_picture_section).to have_image(picture)
end

