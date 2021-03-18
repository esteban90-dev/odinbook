require 'rails_helper'

def accept(friend_request)
  find("[data-test=incoming-friend-request-#{friend_request.id}]").click_on "accept"
end

def ignore(friend_request)
  find("[data-test=incoming-friend-request-#{friend_request.id}]").click_on("ignore")
end

def add_friend(user)
  find("[data-test=user-#{user.id}]").click_on "add friend"
end

def have_sent_friend_request(request)
  have_css("[data-test=sent-friend-request-#{request.id}]", text: request.requestee.name)
end

def incoming_friend_requests
  all(:xpath, '//div[@data-test]'){ |element| element['data-test'].include?('incoming-friend-request') }
end

def sent_friend_requests
  all(:xpath, '//div[@data-test]'){ |element| element['data-test'].include?('sent-friend-request') }
end