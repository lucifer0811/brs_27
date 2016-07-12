class Category < ActiveRecord::Base
  has_many :books

  validates :descriptions, presence: true
  validates :category_name, presence: true
end
