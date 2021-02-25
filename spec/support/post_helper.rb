require 'rails_helper'

def user_sees_post_text(post)
  post_section = find("##{post.id}")
  expect(post_section).to have_content(post.body)
end

def user_sees_post_picture(post)
  post_section = find("##{post.id}")
  expect(post_section).to have_image(post.picture.filename.to_s)
end

