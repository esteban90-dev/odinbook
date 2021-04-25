require 'rails_helper'

describe FriendRequest do 

  context "creating a new record" do 

    it "is not permitted if another friend request already exists where the requestor and requestee are swapped" do 

      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")

      friend_request_1 = FriendRequest.create(requestor: bob, requestee: frank)
      friend_request_2 = FriendRequest.create(requestor: frank, requestee: bob)

      expect(friend_request_2.valid?).to eq(false)
    end

  end

end