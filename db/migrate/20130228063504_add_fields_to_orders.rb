class AddFieldsToOrders < ActiveRecord::Migration
  def self.up
	add_column :orders, :status_timeline, :string
	
  end

  def self.down
	remove_column :orders, :status_timeline
	
  end
end
