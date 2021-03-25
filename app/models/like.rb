class Like < ApplicationRecord
  belongs_to :post
  belongs_to :liker, class_name: "User"

  validates :post, uniqueness: { scope: :liker }
end