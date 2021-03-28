class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  validates :location, presence: true
end