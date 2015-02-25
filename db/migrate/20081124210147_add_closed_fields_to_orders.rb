class AddClosedFieldsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :closed_carrier, :string
    add_column :orders, :closed_tracking_number, :string
    add_column :orders, :closed_comments, :text
  end

  def self.down
    remove_column :orders, :closed_carrier
    remove_column :orders, :closed_tracking_number
    remove_column :orders, :closed_comments
  end
end