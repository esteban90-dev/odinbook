require 'rails_helper'

def add_friend(user)
  within("[data-test=user-#{user.id}]") do 
    find(add_friend_selector).click
  end
end

def incoming_friend_requests
  all(:xpath, '//div[@data-test]'){ |element| element['data-test'].include?('incoming-friend-request') }
end

def sent_friend_requests
  all(:xpath, '//div[@data-test]'){ |element| element['data-test'].include?('sent-friend-request') }
end