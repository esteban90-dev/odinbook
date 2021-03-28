class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  validates :location, presence: true
  validates :relationship_status, presence: true
  validates :education, presence: true
end