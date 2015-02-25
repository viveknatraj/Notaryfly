class AddEmailToAgents < ActiveRecord::Migration
  def self.up
    add_column :agents, :email, :string
  end

  def self.down
    remove_column :agents, :email
  end
end