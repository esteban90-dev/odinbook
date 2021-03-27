class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :incoming_friend_requests, class_name: "FriendRequest", foreign_key: "requestee_id", dependent: :destroy
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: "requestor_id", dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :notifications, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy

  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize do |new_user|
      new_user.email = auth[:info][:email]
      new_user.name = auth[:info][:name]
      new_user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      user = new(session["devise.user_attributes"])
      user.valid?
      return user
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

end
