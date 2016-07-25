class Category < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates :descriptions, presence: true
  validates :category_name, presence: true

  scope :search, ->search {where("category_name LIKE ?",
    "%#{search.squish}%")}


end
