class AddCancelOrderDateToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :cancel_order_date, :date
  end

  def self.down
    remove_column :orders, :cancel_order_date
  end
end
