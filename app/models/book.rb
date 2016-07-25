class Book < ActiveRecord::Base
  belongs_to :category

  validates :title,  presence: true, uniqueness: true
  validates :author,  presence: true
  validates_numericality_of :number_of_page, greater_than: 0
  has_many :reviews, dependent: :destroy
  has_many :book_statuses, dependent: :destroy

  mount_uploader :picture, PictureUploader
  validate :picture_size

  scope :search, ->search {where("title LIKE ? or author LIKE ?",
   "%#{search.squish}%", "%#{search.squish}%")}

  def average_rating
    if self.reviews.size > 0
      self.reviews.average(:rating)
    end
  end

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, t("picture.validate"))
    end
  end
end
