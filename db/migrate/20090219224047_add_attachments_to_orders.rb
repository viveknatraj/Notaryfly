class AddAttachmentsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_attachment_1_file_name, :string
    add_column :orders, :order_attachment_1_content_type, :string
    add_column :orders, :order_attachment_1_file_size, :integer
    add_column :orders, :order_attachment_1_updated_at, :datetime
    add_column :orders, :order_attachment_2_file_name, :string
    add_column :orders, :order_attachment_2_content_type, :string
    add_column :orders, :order_attachment_2_file_size, :integer
    add_column :orders, :order_attachment_2_updated_at, :datetime
    add_column :orders, :order_attachment_3_file_name, :string
    add_column :orders, :order_attachment_3_content_type, :string
    add_column :orders, :order_attachment_3_file_size, :integer
    add_column :orders, :order_attachment_3_updated_at, :datetime
    add_column :orders, :order_attachment_4_file_name, :string
    add_column :orders, :order_attachment_4_content_type, :string
    add_column :orders, :order_attachment_4_file_size, :integer
    add_column :orders, :order_attachment_4_updated_at, :datetime
    add_column :orders, :order_attachment_5_file_name, :string
    add_column :orders, :order_attachment_5_content_type, :string
    add_column :orders, :order_attachment_5_file_size, :integer
    add_column :orders, :order_attachment_5_updated_at, :datetime
    add_column :orders, :order_attachment_6_file_name, :string
    add_column :orders, :order_attachment_6_content_type, :string
    add_column :orders, :order_attachment_6_file_size, :integer
    add_column :orders, :order_attachment_6_updated_at, :datetime
  end

  def self.down
    remove_column :orders, :order_attachment_1_file_name
    remove_column :orders, :order_attachment_1_content_type
    remove_column :orders, :order_attachment_1_file_size
    remove_column :orders, :order_attachment_1_updated_at
    remove_column :orders, :order_attachment_2_file_name
    remove_column :orders, :order_attachment_2_content_type
    remove_column :orders, :order_attachment_2_file_size
    remove_column :orders, :order_attachment_2_updated_at
    remove_column :orders, :order_attachment_3_file_name
    remove_column :orders, :order_attachment_3_content_type
    remove_column :orders, :order_attachment_3_file_size
    remove_column :orders, :order_attachment_3_updated_at
    remove_column :orders, :order_attachment_4_file_name
    remove_column :orders, :order_attachment_4_content_type
    remove_column :orders, :order_attachment_4_file_size
    remove_column :orders, :order_attachment_4_updated_at
    remove_column :orders, :order_attachment_5_file_name
    remove_column :orders, :order_attachment_5_content_type
    remove_column :orders, :order_attachment_5_file_size
    remove_column :orders, :order_attachment_5_updated_at
    remove_column :orders, :order_attachment_6_file_name
    remove_column :orders, :order_attachment_6_content_type
    remove_column :orders, :order_attachment_6_file_size
    remove_column :orders, :order_attachment_6_updated_at
  end
end
