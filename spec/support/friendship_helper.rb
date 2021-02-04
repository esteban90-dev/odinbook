require 'rails_helper'

def unfriend(user)
  find("##{user.id}", text: user.name).click_on "Unfriend"
end