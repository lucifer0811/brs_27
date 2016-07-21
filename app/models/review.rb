class Review < ActiveRecord::Base
  include ActivityLog

  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :book

  validates :title, presence: true
  validates :content, presence: true
  validates :book_id, presence: true
  validates :user_id, presence: true

  after_save :create_review_activity

  private
  def create_review_activity
    create_activity user_id, book_id, Activity.target_types[:book_target],
      Activity.action_types[:reviewed]
  end
end
