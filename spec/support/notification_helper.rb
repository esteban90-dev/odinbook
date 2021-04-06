require 'rails_helper'

def have_bold_notifications_link
  have_css('b', text: 'notifications')
end

def notifications_on_page
  all(:xpath, '//div[@data-test]'){ |element| element['data-test'].include?('notification') }
end