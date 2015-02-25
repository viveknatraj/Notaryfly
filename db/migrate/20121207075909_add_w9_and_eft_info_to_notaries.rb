class AddW9AndEftInfoToNotaries < ActiveRecord::Migration
  def self.up
		add_column :notaries, :w_9, :string
		add_column :notaries, :name, :string
		add_column :notaries, :bank, :string
		add_column :notaries, :routing, :string
		add_column :notaries, :account, :string
  end

  def self.down
		remove_column :notaries, :w_9
		remove_column :notaries, :name
		remove_column :notaries, :bank
		remove_column :notaries, :routing
		remove_column :notaries, :account
  end


end
