class AddStoriesUserIdCollumn < ActiveRecord::Migration
  def self.up
    add_column :stories, :user_id, :integer
  end

  def self.down
    remove_column :stories, :user_id
  end
end
