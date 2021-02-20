require 'rails_helper'

def have_image(filename)
  have_xpath("//img[contains(@src, '#{filename}')]")
end