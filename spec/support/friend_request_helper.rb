require 'rails_helper'

def click_add_friend(user)
  within("##{user.id}") do 
    click_on "Add friend"
  end
end

def accept_friend_request(user)
  within(".incoming") do
    within("##{user.id}") do
      click_on "Accept"
    end
  end
end

def ignore_friend_request(user)
  within(".incoming") do
    within("##{user.id}") do
      click_on "Ignore"
    end
  end
end