class AddPaymentToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :payment, :boolean, :default => false
    add_column :orders, :payment_date, :datetime
    add_column :orders, :client_payment_date, :datetime
  end

  def self.down
    remove_column :orders, :payment
    remove_column :orders, :payment_date
    remove_column :orders, :client_payment_date
  end
end
