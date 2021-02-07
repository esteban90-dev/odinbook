class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :incoming_friend_requests, class_name: "FriendRequest", foreign_key: "requestee_id"
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: "requestor_id"
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :notifications

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
      user.email = auth[:info][:email]
      user.name = auth[:info][:name]
      user.password = Devise.friendly_token[0, 20]
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

  def requested_users
    sent_friend_requests.map{ |fr| fr.requestee }
  end

  def acceptable_users
    incoming_friend_requests.map{ |fr| fr.requestor }
  end
end
