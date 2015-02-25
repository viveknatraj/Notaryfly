class AddAccountDetailsToNotary < ActiveRecord::Migration
  def self.up
    add_column :notaries, :account_type, :string
    add_column :notaries, :account_holder_type, :string
  end

  def self.down
    remove_column :notaries, :account_type
    remove_column :notaries, :account_holder_type
  end
end
