class Post < ApplicationRecord 
  belongs_to :user
  has_one_attached :picture
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, presence: true

  def likers
    self.likes.map{ |like| like.liker }
  end
end