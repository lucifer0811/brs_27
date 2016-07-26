class Category < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates :category_name, presence: true, uniqueness: true
  after_save :downcase_fields

  scope :search, ->search {where("category_name LIKE ?",
    "%#{search.squish}%")}

  def downcase_fields
    self.category_name.downcase
  end
end
