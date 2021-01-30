class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :create_inverse

  private

  def create_inverse
    if Friendship.where(user_id: self.friend_id, friend_id: self.user_id).none?
      Friendship.create(user_id: self.friend_id, friend_id: self.user_id)
    end
  end
end