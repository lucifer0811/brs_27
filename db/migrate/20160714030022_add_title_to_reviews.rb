class AddTitleToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :title, :string, :default => "P"
  end
end
