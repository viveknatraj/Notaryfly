class AddAttachmentsAttachment5ToClient < ActiveRecord::Migration
  def self.up
    add_column :clients, :attachment_5_file_name, :string
    add_column :clients, :attachment_5_content_type, :string
    add_column :clients, :attachment_5_file_size, :integer
    add_column :clients, :attachment_5_updated_at, :datetime
  end

  def self.down
    remove_column :clients, :attachment_5_file_name
    remove_column :clients, :attachment_5_content_type
    remove_column :clients, :attachment_5_file_size
    remove_column :clients, :attachment_5_updated_at
  end
end