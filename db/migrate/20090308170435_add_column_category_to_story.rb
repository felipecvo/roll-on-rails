class AddColumnCategoryToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :category_id, :integer
  end

  def self.down
    remove_column :stories, :category_id
  end
end
