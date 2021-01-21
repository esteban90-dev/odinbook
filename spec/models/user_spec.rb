require 'rails_helper'

describe User, ".from_omniauth" do

  before do
    @auth = {
      info: {
        email: "somebody@example.com",
        name: "somebody"
      },
      provider: "facebook",
      uid: "1234"
    }
  end

  it "returns a user from the db that has the same provider and uid from the auth hash" do
    FactoryBot.create(:user, :from_facebook)
    
    user = User.from_omniauth(@auth)

    expect(User.first).to eq(user)
  end

  it "creates a new user if a user can't be found that matches the provider and uid from the auth hash" do 
    User.from_omniauth(@auth)

    expect(User.first.email).to eq(@auth[:info][:email])
    expect(User.first.name).to eq(@auth[:info][:name])
    expect(User.first.provider).to eq(@auth[:provider])
    expect(User.first.uid).to eq(@auth[:uid])
  end

end