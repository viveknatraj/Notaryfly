class AddOnReConfirmationToOrders < ActiveRecord::Migration
   def self.up
    add_column :orders, :re_confirmation, :integer, :default=>0
  end

  def self.down
    remove_column :orders, :re_confirmation
  end
end
