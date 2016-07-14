class Book < ActiveRecord::Base
  belongs_to :category
  has_many :view, dependent: :destroy

  mount_uploader :picture, PictureUploader
  validate :picture_size

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
