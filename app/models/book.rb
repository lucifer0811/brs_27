class Book < ActiveRecord::Base
  belongs_to :category
  has_many :view, dependent: :destroy
end
