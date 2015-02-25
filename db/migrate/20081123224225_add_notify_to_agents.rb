class AddNotifyToAgents < ActiveRecord::Migration
  def self.up
    add_column :agents, :notify_agent, :string
  end

  def self.down
    remove_column :agents, :notify_agent
  end
end