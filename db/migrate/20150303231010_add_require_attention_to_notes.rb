class AddRequireAttentionToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :require_attention, :boolean, :default => false
  end

  def self.down
    remove_column :notes, :require_attention
  end
end
