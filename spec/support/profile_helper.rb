require 'rails_helper'

def user_sees_profile_picture
  profile_picture_section = find('.profile-picture')
  expect(profile_picture_section).to have_image('eiffel_tower.jpg')
end

def have_image(filename)
  have_xpath("//img[contains(@src, '#{filename}')]")
end