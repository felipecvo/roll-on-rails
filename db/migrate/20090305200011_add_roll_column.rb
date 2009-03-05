class AddRollColumn < ActiveRecord::Migration
  def self.up
    add_column :stories, :rolled, :int, :default => 1
  end

  def self.down
    remove_column :stories, :rolled
  end
end
