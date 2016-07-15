class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.boolean :is_approved
      t.string :book_name
      t references :user, foreign_key: true

      t.timestamps
    end
    add_index :requests, [:user_id, :created_at]
  end
end
