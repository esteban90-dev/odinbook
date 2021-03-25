require 'rails_helper'

describe Friendship do 

  context "when created" do 

    it "creates an additional record where the user_id and friend_id are swapped" do
      joe = FactoryBot.create(:user, name: "joe", email: "joe@mail.com")
      bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
      Friendship.create(user: joe, friend: bob)

      expect(Friendship.find_by_user_id(bob.id)).not_to be_nil
    end
    
  end

  context "when destroyed" do

    it "destroys the inverse record" do
      joe = FactoryBot.create(:user, name: "joe", email: "joe@mail.com")
      bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
      friendship = Friendship.create(user: joe, friend: bob)
      inverse_friendship = Friendship.find_by_user_id(bob.id)

      friendship.destroy

      expect(Friendship.all).not_to include(friendship, inverse_friendship)
    end

  end

  context "uniqueness validation" do 

    it "doesn't permit the creation of a friendship record if another record exists with the same user and friend" do
      joe = FactoryBot.create(:user, name: "joe", email: "joe@mail.com")
      bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
      joe.friends << bob

      Friendship.create(user: joe, friend: bob)

      #one 'friendship' consists of 2 records - the second record is an inverse of the first
      expect(Friendship.all.count).to eq(2)
    end

  end

end