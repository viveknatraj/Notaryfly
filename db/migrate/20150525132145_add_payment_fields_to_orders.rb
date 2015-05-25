class AddPaymentFieldsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :notary_payment, :boolean, :default => false
    add_column :orders, :executive_payment, :boolean, :default => false
		add_column :orders, :executive_payment_date, :datetime
		rename_column :orders, :payment_date, :notary_payment_date
  end

  def self.down
    remove_column :orders, :notary_payment
    remove_column :orders, :executive_payment
		remove_column :orders, :notary_payment_date
		remove_column :orders, :executive_payment_date
  end
end
