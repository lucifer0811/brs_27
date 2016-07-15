
class User < ActiveRecord::Base
  include SessionsHelper
  before_save {email.downcase!}

  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  has_secure_password

  has_many :requests, dependent: :destroy
  has_many :active_relationships,  class_name:  "UserRelationship",
    foreign_key: "follower_id", dependent:   :destroy
  has_many :passive_relationships, class_name:  "UserRelationship",
    foreign_key: "followed_id", dependent:   :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :review, dependent: :destroy

  # Follows a user.
  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  # Unfollows a user.
  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following? other_user
    following.include? other_user
  end

end
