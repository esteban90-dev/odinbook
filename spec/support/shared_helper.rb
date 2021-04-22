require 'rails_helper'

def have_image(filename)
  have_xpath("//img[contains(@src, '#{filename}')]")
end

def user_sees_content_order_descending(text_1, text_2)
  expect(page.body.index(text_2) < page.body.index(text_1)).to eq(true)
end

def be_timeline
  have_css("[data-test=timeline]")
end

def nav_section
  '[data-test="nav"]'
end

def user_appears_signed_in(user_name)
  expect(find(nav_section)).to have_content(user_name)
end

def user_doesnt_appear_signed_in(user_name)
  expect(find(nav_section)).not_to have_content(user_name)
end

def add_friend_selector
  '[data-test="add-friend"]'
end