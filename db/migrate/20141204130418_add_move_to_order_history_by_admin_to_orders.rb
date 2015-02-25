class AddMoveToOrderHistoryByAdminToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :move_to_order_history_by_admin, :boolean, :default => false
  end

  def self.down
    remove_column :orders, :move_to_order_history_by_admin
  end
end
