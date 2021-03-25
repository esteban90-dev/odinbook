class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user, uniqueness: { scope: :friend }

  after_create :create_inverse
  after_destroy :destroy_inverse

  private

  def create_inverse
    if Friendship.where(user_id: self.friend_id, friend_id: self.user_id).none?
      Friendship.create(user_id: self.friend_id, friend_id: self.user_id)
    end
  end

  def destroy_inverse
    unless Friendship.where(user_id: self.friend_id, friend_id: self.user_id).none?
      Friendship.where(user_id: self.friend_id, friend_id: self.user_id).first.destroy
    end
  end
end