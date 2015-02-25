class AddTotalRevenueToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :total_revenue, :text
  end

  def self.down
    remove_column :orders, :total_revenue
  end
end
