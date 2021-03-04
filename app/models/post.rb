class Post < ApplicationRecord 
  belongs_to :user
  has_one_attached :picture
  has_many :likes
  has_many :comments

  def likers
    self.likes.map{ |like| like.liker }
  end
end