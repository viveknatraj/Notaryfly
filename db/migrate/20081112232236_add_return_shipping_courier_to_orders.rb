class AddReturnShippingCourierToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :return_shipping_courier, :string
  end

  def self.down
    remove_column :orders, :return_shipping_courier
  end
end
