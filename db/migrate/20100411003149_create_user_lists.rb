class CreateUserLists < ActiveRecord::Migration
  def self.up
    create_table :user_lists do |t|
      t.integer :list_id, :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_lists
  end
end
