class FriendRequest < ApplicationRecord
  belongs_to :requestee, class_name: "User"
  belongs_to :requestor, class_name: "User"
end