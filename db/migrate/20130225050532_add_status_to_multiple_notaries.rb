class AddStatusToMultipleNotaries < ActiveRecord::Migration
  def self.up
	add_column :multiple_notaries, :status, :string
	add_column :multiple_notaries, :accept_status, :boolean, :default => false
  end

  def self.down
	remove_column :multiple_notaries, :status
	remove_column :multiple_notaries, :accept_status
  end
end
