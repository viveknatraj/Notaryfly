class AddDocDeliveryAddressOptionOnOrders < ActiveRecord::Migration
 def self.up
    add_column :orders, :doc_delivery_address_option, :string
  end

  def self.down
    remove_column :orders, :doc_delivery_address_option
  end
end
