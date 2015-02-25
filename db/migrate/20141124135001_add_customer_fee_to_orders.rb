class AddCustomerFeeToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :customer_fee, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :orders, :customer_fee
  end
end
