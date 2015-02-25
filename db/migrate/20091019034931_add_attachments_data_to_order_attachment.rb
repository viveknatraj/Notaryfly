class AddAttachmentsDataToOrderAttachment < ActiveRecord::Migration
  def self.up
    add_column :order_attachments, :data_file_name, :string
    add_column :order_attachments, :data_content_type, :string
    add_column :order_attachments, :data_file_size, :integer
    add_column :order_attachments, :data_updated_at, :datetime
  end

  def self.down
    remove_column :order_attachments, :data_file_name
    remove_column :order_attachments, :data_content_type
    remove_column :order_attachments, :data_file_size
    remove_column :order_attachments, :data_updated_at
  end
end