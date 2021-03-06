require 'rails_helper'

describe User, ".from_omniauth" do

  before do
    @auth = {
      info: {
        email: "somebody@example.com",
        name: "somebody"
      },
      provider: "facebook",
      uid: "12345"
    }
  end

  it "returns a user from the db that has the same provider and uid from the auth hash" do
    FactoryBot.create(:user, :from_facebook)
    
    user = User.from_omniauth(@auth)

    expect(User.first).to eq(user)
  end

  it "creates a new user if a user can't be found that matches the provider and uid from the auth hash" do 
    new_user = User.from_omniauth(@auth)

    expect(new_user.email).to eq(@auth[:info][:email])
    expect(new_user.name).to eq(@auth[:info][:name])
    expect(new_user.provider).to eq(@auth[:provider])
    expect(new_user.uid).to eq(@auth[:uid])
    expect(new_user.new_record?).to be(true)
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

describe User do 

  context "when created" do 

    it "sends a welcome email to the user" do 
      allow(UserMailer).to receive_message_chain(:welcome_email, :deliver_now)

      user = FactoryBot.create(:user)

      expect(UserMailer).to have_received(:welcome_email).with(user)
    end

    it "creates a default profile" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")

      expect(bob.profile.location).to eq("unknown")
      expect(bob.profile.education).to eq("High School")
      expect(bob.profile.relationship_status).to eq("Single")
      expect(bob.profile.picture.attached?).to eq(true)
    end

    it "creates a welcome notification" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")

      expect(bob.notifications.first.message).to eq("Welcome to Odinbook!")
    end

  end

  context "when destroyed" do 

    it "destroys dependent incoming friend requests" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
      FriendRequest.create(requestor: joe, requestee: bob)

      bob.destroy

      expect(FriendRequest.all.count).to eq(0)
    end

    it "destroys dependent sent friend requests" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
      FriendRequest.create(requestor: joe, requestee: bob)

      joe.destroy

      expect(FriendRequest.all.count).to eq(0)
    end

    it "destroys dependent friendships" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      joe = FactoryBot.create(:user, name: "joe", email: "joe@example.com")
      bob.friends << joe

      bob.destroy

      expect(Friendship.all.count).to eq(0)
    end

    it "destroys dependent notifications" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      bob.notifications.create(message: "hello bob!")

      bob.destroy

      expect(Notification.all.count).to eq(0)
    end

    it "destroys dependent posts" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      bob.posts.create(body: "this is a post")

      bob.destroy

      expect(Post.all.count).to eq(0)
    end

    it "destroys dependent profile" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")

      bob.destroy

      expect(Profile.all.count).to eq(0)
    end

  end

end
