class AddAdminOrderCancelToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :admin_order_cancel, :text
  end

  def self.down
    remove_column :orders, :admin_order_cancel
  end
end
