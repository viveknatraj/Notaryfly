class AddAgentIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :agent_id, :integer
  end

  def self.down
    remove_column :orders, :agent_id
  end
end
