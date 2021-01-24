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

describe User, ".new_with_session" do

  it "returns a new user object built from data in the session hash" do
    params_hash = {}
    session_hash = {}
    session_hash["devise.user_attributes"] = { email: "somebody@example.com", name: "somebody", uid: "1234", provider: "facebook" }

    new_user_from_session = User.new_with_session(params_hash, session_hash)

    expect(new_user_from_session.email).to eq("somebody@example.com")
    expect(new_user_from_session.name).to eq("somebody")
    expect(new_user_from_session.uid).to eq("1234")
    expect(new_user_from_session.email).to eq("somebody@example.com")
  end

  it "returns a new user object if the session hash doesn't contain user attribute data" do
    params_hash = {}
    session_hash = {}

    new_user_from_session = User.new_with_session(params_hash, session_hash)

    expect(new_user_from_session.attributes).to eq(User.new.attributes)
  end

end

describe User, "#password_required?" do

  it "returns false if the user object's provider field has a value" do
    facebook_user = FactoryBot.create(:user, :from_facebook)

    expect(facebook_user.password_required?).to eq(false)
  end

  it "returns true if the user objects' provider field is blank" do
    regular_user = FactoryBot.create(:user)

    expect(regular_user.password_required?).to eq(true)
  end

end 