class Comment < ActiveRecord::Base
  include ActivityLog

  belongs_to :review
  belongs_to :user
  scope :most_recent, -> {order("created_at desc")}
  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :content, presence: true

  after_save :create_comment_activity

  private
  def create_comment_activity
     create_activity user_id, review.book_id,
       Activity.target_types[:book_target], Activity.action_types[:commented]
  end
end
