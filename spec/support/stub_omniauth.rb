require 'rails_helper'

def stub_omniauth_successful
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    info: {
      email: "somebody@example.com",
      name: "somebody"
    },
      :provider => 'facebook',
      :uid => '12345'
  })
end

def stub_omniauth_unsuccessful
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    info: {
      name: "somebody"
    },
      :provider => 'facebook',
      :uid => '12345'
  })
end