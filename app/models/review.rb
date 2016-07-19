class Review < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :book

  validates :title, presence: true
  validates :content, presence: true
  validates :book_id, presence: true
  validates :user_id, presence: true

end
