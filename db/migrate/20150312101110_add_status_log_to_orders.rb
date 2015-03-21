class AddStatusLogToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :status_log, :text
  end

  def self.down
    remove_column :orders, :status_log, :text
  end
end
