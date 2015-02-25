class AddCancelOrderToOrders < ActiveRecord::Migration
  def self.up
	add_column :orders, :cancel_order, :text
  end

  def self.down
	remove_column :orders, :cancel_order
  end
end
