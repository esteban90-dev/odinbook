require 'rails_helper'

def unfriend(user)
  find("[data-test=user-#{user.id}]").click_on "unfriend"
end