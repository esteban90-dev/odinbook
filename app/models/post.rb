class Post < ApplicationRecord 
  belongs_to :user
  has_one_attached :picture
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :picture, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }
  validate :must_have_text_or_picture

  def likers
    self.likes.map{ |like| like.liker }
  end

  def must_have_text_or_picture
    if !picture.attached? && body.blank?
      errors.add(:base, "must have text or picture")
    end
  end
end