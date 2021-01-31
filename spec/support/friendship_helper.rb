require 'rails_helper'

def unfriend(user)
  within("##{user.id}") do
    click_on "Unfriend"
  end
end