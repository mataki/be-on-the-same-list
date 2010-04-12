class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :screen_name
      t.string :profile_image_url

      t.datetime :fetched_at

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
