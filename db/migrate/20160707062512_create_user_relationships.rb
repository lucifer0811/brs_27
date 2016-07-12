class CreateUserRelationships < ActiveRecord::Migration
  def change
    create_table :user_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    add_index :user_relationship, :follower_id
    add_index :user_relationship, :followed_id
    add_index :user_relationship, [:follower_id, :followed_id], unique: true

  end

end
