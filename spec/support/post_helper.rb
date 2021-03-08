require 'rails_helper'

def edit_post_with_new_text(post, new_post_text)
  within("##{post.id}") do 
    click_on "edit"
  end
  fill_in "Body", with: new_post_text
  click_on "Update Post"
end

def edit_post_with_new_image(post, image_path)
  within("##{post.id}") do 
    click_on "edit"
  end
  attach_file "Picture", image_path
  click_on "Update Post"
end

def delete_post(post)
  within("##{post.id}") do 
    click_on "delete"
  end
end

def user_sees_post_text(post)
  post_section = find("##{post.id}")
  expect(post_section).to have_content(post.body)
end

def user_sees_modified_post_text(original_post, new_post_text)
  post_section = find("##{original_post.id}")
  expect(post_section).to have_content(new_post_text)
end

def user_sees_post_picture(post)
  post_section = find("##{post.id}")
  expect(post_section).to have_image(post.picture.filename.to_s)
end

def user_sees_modified_post_picture(original_post, image_filename)
  post_section = find("##{original_post.id}")
  expect(post_section).to have_image(image_filename)
end



