require 'rails_helper'

def click_add_friend(user)
  within("##{user.id}") do 
    click_on "Add friend"
  end
end