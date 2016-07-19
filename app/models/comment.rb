class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  scope :most_recent, -> {order("created_at desc")}
  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :content, presence: true
end
