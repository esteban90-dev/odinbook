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