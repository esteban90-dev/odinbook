class FriendRequest < ApplicationRecord
  belongs_to :requestee, class_name: "User"
  belongs_to :requestor, class_name: "User"

  validates :requestee, uniqueness: { scope: :requestor }
  validate :reverse_must_not_exist

  def reverse_must_not_exist
    if FriendRequest.where(requestor_id: self.requestee.id, requestee_id: self.requestor.id).any?
      errors.add(:base, "reverse request already exists")
    end
  end
end