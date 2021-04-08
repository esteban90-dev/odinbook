class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  validates :location, presence: true
  validates :relationship_status, presence: true
  validates :education, presence: true
  validates :picture, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }

  before_create :attach_generic_picture

  private

  def attach_generic_picture
    unless picture.attached?
      picture.attach(io: File.open(ENV['generic_profile_picture_path']), filename: ENV['generic_profile_picture_filename'], content_type: 'image/png')
    end
  end
end