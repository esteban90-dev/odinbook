require 'rails_helper'

def have_user(user)
  have_css("##{user.id}", text: user.name)
end