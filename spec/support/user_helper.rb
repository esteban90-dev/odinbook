require 'rails_helper'

def have_user(user)
  have_css("[data-test=user-#{user.id}]", text: user.name)
end