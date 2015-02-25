class AddOrderNotaryFeeDateToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_notary_fee_date, :date
  end

  def self.down
    remove_column :orders, :order_notary_fee_date
  end
end
