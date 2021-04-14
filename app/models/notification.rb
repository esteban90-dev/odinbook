class Notification < ApplicationRecord
  belongs_to :user

  validates :message, presence: true

  def self.unacked
    where("created_at = updated_at")
  end
end