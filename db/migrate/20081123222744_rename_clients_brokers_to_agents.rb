class RenameClientsBrokersToAgents < ActiveRecord::Migration
  def self.up
     rename_table('client_brokers', 'agents')
  end

  def self.down
    rename_table('agents', 'client_brokers')
  end
end
