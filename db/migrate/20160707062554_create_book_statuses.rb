class CreateBookStatuses < ActiveRecord::Migration
  def change
    create_table :book_statuses do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :reading_status, default: 0
      t.boolean :is_favorite, default: false

      t.timestamps null: false
    end
  end
end
