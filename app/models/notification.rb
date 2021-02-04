class Notification < ApplicationRecord

  def self.unacked
    where("created_at = updated_at")
  end

end