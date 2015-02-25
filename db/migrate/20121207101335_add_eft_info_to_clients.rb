class AddEftInfoToClients < ActiveRecord::Migration
  def self.up
		add_column :clients, :name, :string
		add_column :clients, :bank, :string
		add_column :clients, :routing, :string
		add_column :clients, :account, :string
  end

  def self.down
		remove_column :clients, :name
		remove_column :clients, :bank
		remove_column :clients, :routing
		remove_column :clients, :account
  end
end
