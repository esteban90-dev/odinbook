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

end