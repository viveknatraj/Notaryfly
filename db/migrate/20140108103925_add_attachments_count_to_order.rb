class AddAttachmentsCountToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :attachments_count, :integer
  end

  def self.down
    remove_column :orders, :attachments_count
  end
end
