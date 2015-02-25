class AddFieldsToMultipleNotaries < ActiveRecord::Migration
  def self.up
	add_column :multiple_notaries, :mail_count, :integer, :default => 0
  end

  def self.down
	remove_column :multiple_notaries, :mail_count
  end
end
