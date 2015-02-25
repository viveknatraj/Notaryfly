class AddSplInstructionAttachmentFieldsOnOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :attachment_1_file_name, :string
    add_column :orders, :attachment_1_file_url, :string
    add_column :orders, :attachment_2_file_name, :string
    add_column :orders, :attachment_2_file_url, :string
    add_column :orders, :attachment_3_file_name, :string
    add_column :orders, :attachment_3_file_url, :string
    add_column :orders, :attachment_4_file_name, :string
    add_column :orders, :attachment_4_file_url, :string
    add_column :orders, :attachment_5_file_name, :string
    add_column :orders, :attachment_5_file_url, :string
    add_column :orders, :attachment_6_file_name, :string
    add_column :orders, :attachment_6_file_url, :string
  end

  def self.down
    remove_column :orders, :attachment_1_file_name, :string
    remove_column :orders, :attachment_1_file_url, :string
    remove_column :orders, :attachment_2_file_name, :string
    remove_column :orders, :attachment_2_file_url, :string
    remove_column :orders, :attachment_3_file_name, :string
    remove_column :orders, :attachment_3_file_url, :string
    remove_column :orders, :attachment_4_file_name, :string
    remove_column :orders, :attachment_4_file_url, :string
    remove_column :orders, :attachment_5_file_name, :string
    remove_column :orders, :attachment_5_file_url, :string
    remove_column :orders, :attachment_6_file_name, :string
    remove_column :orders, :attachment_6_file_url, :string
  end
end
