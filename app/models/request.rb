class Request < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :book_name, presence: true, length: { maximum: 140 }
end
