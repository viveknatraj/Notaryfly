class AddAdminOrderCancelDateToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :admin_order_cancel_date, :date
  end

  def self.down
    remove_column :orders, :admin_order_cancel_date
  end
end
