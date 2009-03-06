class CreateStoriesTags < ActiveRecord::Migration
  def self.up
    create_table :stories_tags do |t|
      t.integer :story_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stories_tags
  end
end
