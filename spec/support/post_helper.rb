require 'rails_helper'

def delete_post(post)
  find("[data-test=post-#{post.id}]").click_on "delete"
end

def edit_post_text(post, new_post_text)
  find("[data-test=post-#{post.id}]").click_on "edit"
  fill_in "Body", with: new_post_text
  click_on "Update Post"
end

def edit_post_picture(post, new_file_path)
  find("[data-test=post-#{post.id}]").click_on "edit"
  attach_file "Picture", new_file_path
  click_on "Update Post"
end

def create_post_with_picture(post_text, file_path)
  fill_in "Body", with: post_text
  attach_file "Picture", file_path
  click_on "create post"
end

def have_post_author_name(post)
  have_css("[data-test=post-#{post.id}]", text: post.user.name)
end

def posts_on_page
  all(:xpath, '//div[@data-test]'){ |element| element['data-test'].include?('post') }
end

def post_doesnt_appear_editable(post)
  within("[data-test=post-#{post.id}]") do 
    expect(page).not_to have_link("edit")
  end
end

def post_doesnt_appear_deletable(post)
  within("[data-test=post-#{post.id}]") do 
    expect(page).not_to have_link("delete")
  end
end