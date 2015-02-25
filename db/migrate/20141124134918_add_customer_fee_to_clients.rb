class AddCustomerFeeToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :customer_fee, :decimal, :precision =>8, :scale => 2
  end

  def self.down
    remove_column :clients, :customer_fee
  end
end
