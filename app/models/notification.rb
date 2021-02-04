class Notification < ApplicationRecord

  def self.unacked
    where("created_at = updated_at")
  end

  def unacked?
    return true if self.created_at == self.updated_at
    false
  end

end