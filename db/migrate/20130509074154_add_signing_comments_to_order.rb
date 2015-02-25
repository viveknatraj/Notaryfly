class AddSigningCommentsToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :signing_comments, :text
  end

  def self.down
    remove_column :orders, :signing_comments
  end
end
